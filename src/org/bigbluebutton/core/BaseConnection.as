package org.bigbluebutton.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.command.DisconnectUserSignal;
	import org.bigbluebutton.model.ConnectionFailedEvent;
	import org.bigbluebutton.view.navigation.pages.disconnect.enum.DisconnectEnum;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;
	
	public class BaseConnection implements IBaseConnection
	{	
		[Inject]
		public var disconnectUserSignal:DisconnectUserSignal;
					
		public static const NAME:String = "BaseConnection";
		
		protected var _successConnected:ISignal = new Signal();
		protected var _unsuccessConnected:ISignal = new Signal();
		
		protected var _netConnection:NetConnection;
		protected var _uri:String;
		protected var _onUserCommand:Boolean;

		public function BaseConnection() {
			Log.getLogger("org.bigbluebutton").info(String(this));
		}
		
		public function init(callback:IDefaultConnectionCallback):void
		{
			_netConnection = new NetConnection();
			_netConnection.client = callback;
			_netConnection.addEventListener( NetStatusEvent.NET_STATUS, netStatus );
			_netConnection.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
			_netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, netSecurityError );
			_netConnection.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
		}
		
		public function get unsuccessConnected():ISignal
		{
			return _unsuccessConnected;
		}

		public function get successConnected():ISignal
		{
			return _successConnected;
		}

		public function get connection():NetConnection {
			return _netConnection;
		}
		
		public function connect(uri:String, ...parameters):void {
			_uri = uri;

			// The connect call needs to be done properly. At the moment lock settings
			// are not implemented in the mobile client, so parameters[7] and parameters[8]
			// are "faked" in order to connect (without them, I couldn't get the connect 
			// call to work...) - Adam
			//parameters[7] = false;
			//parameters[8] = false;
			
			try {
				trace("Trying to connect to [" + uri +  "] ...");
				// passing an array to a method that expects a variable number of parameters
				// http://stackoverflow.com/a/3852920
				_netConnection.connect.apply(null, new Array(uri).concat(parameters));
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
				sendConnectionFailedEvent(e.message);
			}
		}
		
		public function disconnect(onUserCommand:Boolean):void {
			_onUserCommand = onUserCommand;
			_netConnection.close();
		}
		
		protected function netStatus(event:NetStatusEvent):void {
			var info : Object = event.info;
			var statusCode : String = info.code;
			
			switch (statusCode) {
				case "NetConnection.Connect.Success":
					trace(NAME + ": Connection succeeded. Uri: " + _uri);
					sendConnectionSuccessEvent();
					break;
				
				case "NetConnection.Connect.Failed":				
					trace(NAME + ": Connection failed. Uri: " + _uri);
					sendConnectionFailedEvent(ConnectionFailedEvent.CONNECTION_FAILED);
					break;
				
				case "NetConnection.Connect.Closed":
					trace(NAME + ": Connection closed. Uri: " + _uri);
					sendConnectionFailedEvent(ConnectionFailedEvent.CONNECTION_CLOSED);		
					break;
				
				case "NetConnection.Connect.InvalidApp":	
					trace(NAME + ": application not found on server. Uri: " + _uri);			
					sendConnectionFailedEvent(ConnectionFailedEvent.INVALID_APP);				
					break;
				
				case "NetConnection.Connect.AppShutDown":
					trace(NAME + ": application has been shutdown. Uri: " + _uri);
					sendConnectionFailedEvent(ConnectionFailedEvent.APP_SHUTDOWN);	
					break;
				
				case "NetConnection.Connect.Rejected":
					trace(NAME + ": Connection to the server rejected. Uri: " + _uri + ". Check if the red5 specified in the uri exists and is running" );
					sendConnectionFailedEvent(ConnectionFailedEvent.CONNECTION_REJECTED);		
					break;
				
				case "NetConnection.Connect.NetworkChange":
					trace("Detected network change. User might be on a wireless and temporarily dropped connection. Doing nothing. Just making a note.");
					break;
				
				default :
					trace(NAME + ": Default status");
					sendConnectionFailedEvent(ConnectionFailedEvent.UNKNOWN_REASON);
					break;
			}
		}
	
		protected function sendConnectionSuccessEvent():void 
		{
			successConnected.dispatch();
		}
		
		protected function sendConnectionFailedEvent(reason:String):void 
		{
			//unsuccessConnected.dispatch(reason);
			disconnectUserSignal.dispatch(DisconnectEnum.CONNECTION_STATUS_CONNECTION_DROPPED);
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
		
		public function sendMessage(service:String, onSuccess:Function, onFailure:Function, message:Object=null):void {
			trace("SENDING MESSAGE: [" + service + "]");
			var responder:Responder =	new Responder(                    
				function(result:Object):void { // On successful result
					onSuccess("SUCCESSFULLY SENT: [" + service + "]."); 
				},	                   
				function(status:Object):void { // status - On error occurred
					var errorReason:String = "FAILED TO SEND: [" + service + "]:"; 
					for (var x:Object in status) { 
						errorReason += "\n - " + x + " : " + status[x]; 
					}
					onFailure(errorReason);
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
