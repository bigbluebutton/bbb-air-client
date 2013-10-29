package org.mconf.mobile.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.utils.Timer;
	
	import mx.utils.ObjectUtil;
	
	import org.mconf.mobile.model.ConferenceParameters;
	import org.mconf.mobile.model.ConnectionFailedEvent;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.osmf.logging.Log;
	
	public class BigBlueButtonConnection implements IBigBlueButtonConnection
	{
		public static const NAME:String = "BigBlueButtonConnection";
		
		private var _netConnection:NetConnection;
		private var _applicationURI:String;
		private var _conferenceParameters:IConferenceParameters;
		private var _tried_tunneling:Boolean = false;
		private var _logoutOnUserCommand:Boolean = false;
		
		public function BigBlueButtonConnection() {
			Log.getLogger("org.mconf.mobile").info(String(this));
			
			_netConnection = new NetConnection();
			_netConnection.client = this;
			_netConnection.addEventListener( NetStatusEvent.NET_STATUS, netStatus );
			_netConnection.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
			_netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, netSecurityError );
			_netConnection.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
		}
		
		public function set uri(uri:String):void {
			_applicationURI = uri;
		}
		
		public function get connection():NetConnection {
			return _netConnection;
		}
		
		/**
		 * Connect to the server.
		 * uri: The uri to the conference application.
		 * username: Fullname of the participant.
		 * role: MODERATOR/VIEWER
		 * conference: The conference room
		 * mode: LIVE/PLAYBACK - Live:when used to collaborate, Playback:when being used to playback a recorded conference.
		 * room: Need the room number when playing back a recorded conference. When LIVE, the room is taken from the URI.
		 */
		public function connect(params:IConferenceParameters, tunnel:Boolean = false):void {	
			_conferenceParameters = params;
			_tried_tunneling = tunnel;
			
			try {
				var uri:String = _applicationURI + "/" + _conferenceParameters.room;
				
				trace("Connecting to " + uri + "[" + 
						_conferenceParameters.username + "," + 
						_conferenceParameters.role + "," + 
						_conferenceParameters.conference + "," + 
						_conferenceParameters.record + "," + 
						_conferenceParameters.room + "]");	
				_netConnection.connect(uri, 
						_conferenceParameters.username, 
						_conferenceParameters.role,
						_conferenceParameters.room, 
						_conferenceParameters.voicebridge, 
						_conferenceParameters.record, 
						_conferenceParameters.externUserID,
						_conferenceParameters.internalUserID);
			} catch(e:ArgumentError) {
				trace(ObjectUtil.toString(e));
				// Invalid parameters.
				switch (e.errorID) {
					case 2004 :						
						trace("Error! Invalid server location: " + uri);											   
						break;						
					default :
						trace("UNKNOWN Error! Invalid server location: " + uri);
						break;
				}
			}
		}
		
		public function disconnect(logoutOnUserCommand:Boolean):void {
			_logoutOnUserCommand = logoutOnUserCommand;
			_netConnection.close();
		}
		
		protected function netStatus(event:NetStatusEvent):void {
			var info : Object = event.info;
			var statusCode : String = info.code;
			
			switch (statusCode) {
				case "NetConnection.Connect.Success":
					trace(NAME + ":Connection to viewers application succeeded.");
					_netConnection.call(
						"getMyUserId",// Remote function name
						new Responder(
							// result - On successful result
							function(result:Object):void { 
								trace("Userid [" + result + "]"); 
								sendConnectionSuccessEvent(result);
							},	
							// status - On error occurred
							function(status:Object):void { 
								trace("Error occurred");
								trace(ObjectUtil.toString(status));
							}
						)//new Responder
					); //_netConnection.call
					
					break;
				
				case "NetConnection.Connect.Failed":					
					if (_tried_tunneling) {
						trace(NAME + ":Connection to viewers application failed...even when tunneling");
						sendConnectionFailedEvent(ConnectionFailedEvent.CONNECTION_FAILED);
					} else {
						disconnect(false);
						trace(NAME + ":Connection to viewers application failed...try tunneling");
						var rtmptRetryTimer:Timer = new Timer(1000, 1);
						rtmptRetryTimer.addEventListener("timer", rtmptRetryTimerHandler);
						rtmptRetryTimer.start();						
					}									
					break;
				
				case "NetConnection.Connect.Closed":	
					trace(NAME + ":Connection to viewers application closed");		
					//          if (logoutOnUserCommand) {
					sendConnectionFailedEvent(ConnectionFailedEvent.CONNECTION_CLOSED);		
					//          } else {
					//            autoReconnectTimer.addEventListener("timer", autoReconnectTimerHandler);
					//            autoReconnectTimer.start();		
					//          }
					
					break;
				
				case "NetConnection.Connect.InvalidApp":	
					trace(NAME + ":viewers application not found on server");			
					sendConnectionFailedEvent(ConnectionFailedEvent.INVALID_APP);				
					break;
				
				case "NetConnection.Connect.AppShutDown":
					trace(NAME + ":viewers application has been shutdown");
					sendConnectionFailedEvent(ConnectionFailedEvent.APP_SHUTDOWN);	
					break;
				
				case "NetConnection.Connect.Rejected":
					trace(NAME + ":Connection to the server rejected. Uri: " + _applicationURI + ". Check if the red5 specified in the uri exists and is running" );
					sendConnectionFailedEvent(ConnectionFailedEvent.CONNECTION_REJECTED);		
					break;
				
				case "NetConnection.Connect.NetworkChange":
					trace("Detected network change. User might be on a wireless and temporarily dropped connection. Doing nothing. Just making a note.");
					break;
				
				default :
					trace(NAME + ":Default status to the viewers application" );
					sendConnectionFailedEvent(ConnectionFailedEvent.UNKNOWN_REASON);
					break;
			}
		}
		
		private function rtmptRetryTimerHandler(event:TimerEvent):void {
			trace(NAME + "rtmptRetryTimerHandler: " + event);
			connect(_conferenceParameters, true);
		}
		
		protected function sendConnectionSuccessEvent(userid:Object):void {
			
		}
		
		protected function sendConnectionFailedEvent(reason:String):void {
			
		}
		
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
			trace("Security error - " + event.text);
			sendConnectionFailedEvent(ConnectionFailedEvent.UNKNOWN_REASON);
		}
		
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			trace("Input/output error - " + event.text);
			sendConnectionFailedEvent(ConnectionFailedEvent.UNKNOWN_REASON);
		}
		
		protected function netASyncError( event : AsyncErrorEvent ) : void 
		{
			trace("Asynchronous code error - " + event.error );
			sendConnectionFailedEvent(ConnectionFailedEvent.UNKNOWN_REASON);
		}
		
		public function onBWCheck(... rest):Number {
			return 0; 
		} 
		
		public function onBWDone(... rest):void { 
			trace("onBWDone() " + ObjectUtil.toString(rest));
			var p_bw:Number; 
			if (rest.length > 0) p_bw = rest[0]; 
			// your application should do something here 
			// when the bandwidth check is complete 
			trace("bandwidth = " + p_bw + " Kbps."); 
		}
		
		public function onMessageFromServer(messageName:String, result:Object):void {
			trace("Got message from server [" + messageName + "]\n" + ObjectUtil.toString(result));    
		}
		
		public function sendMessage(service:String, onSuccess:Function, onFailure:Function, message:Object=null):void {
			trace("SENDING [" + service + "]");
			var responder:Responder =	new Responder(                    
				function(result:Object):void { // On successful result
					onSuccess("Successfully sent [" + service + "]."); 
				},	                   
				function(status:Object):void { // status - On error occurred
					var errorReason:String = "Failed to send [" + service + "]:\n"; 
					for (var x:Object in status) { 
						errorReason += "\t" + x + " : " + status[x]; 
					} 
				}
			);
			
			if (message == null) {
				_netConnection.call(service, responder);			
			} else {
				_netConnection.call(service, responder, message);
			}
		}		
	}
}
