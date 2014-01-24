package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.model.IConferenceParameters;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;
	
	public class BigBlueButtonConnection extends DefaultConnectionCallback implements IBigBlueButtonConnection
	{
		public static const NAME:String = "BigBlueButtonConnection";
		
		protected var _successConnected:ISignal = new Signal();
		protected var _unsuccessConnected:ISignal = new Signal();
		protected var _baseConnection:BaseConnection;
		
		private var _applicationURI:String;
		private var _conferenceParameters:IConferenceParameters;
		private var _tried_tunneling:Boolean = false;
		private var _logoutOnUserCommand:Boolean = false;
		private var _userId:String;
		
		public function BigBlueButtonConnection() {
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			_baseConnection = new BaseConnection(this);
			_baseConnection.successConnected.add(onConnectionSuccess);
			_baseConnection.unsuccessConnected.add(onConnectionUnsuccess);
		}
		
		private function onConnectionUnsuccess(reason:String):void
		{
			unsuccessConnected.dispatch(reason);
		}
		
		private function onConnectionSuccess():void
		{
			getMyUserId();
		}
		
		private function getMyUserId():void {
			_baseConnection.connection.call(
				"getMyUserId",// Remote function name
				new Responder(
					// result - On successful result
					function(result:Object):void {
						_userId = result as String;
						successConnected.dispatch();
					},	
					// status - On error occurred
					function(status:Object):void { 
						trace("Error occurred");
						trace(ObjectUtil.toString(status));
						unsuccessConnected.dispatch("Failed to get the userId");
					}
				)//new Responder
			); //_netConnection.call
		}
		
		public function get unsuccessConnected():ISignal
		{
			return _unsuccessConnected;
		}

		public function get successConnected():ISignal
		{
			return _successConnected;
		}

		public function set uri(uri:String):void {
			_applicationURI = uri;
		}

		public function get uri():String {
			return _applicationURI;
		}

		
		public function get connection():NetConnection {
			return _baseConnection.connection;
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
			
			var uri:String = _applicationURI + "/" + _conferenceParameters.room;
			var connectParams:Array = [
				_conferenceParameters.username, 
				_conferenceParameters.role,
				_conferenceParameters.room, 
				_conferenceParameters.voicebridge, 
				_conferenceParameters.record, 
				_conferenceParameters.externUserID,
				_conferenceParameters.internalUserID
			];
			if (_conferenceParameters.isGuestDefined()) {
				connectParams.push(_conferenceParameters.guest);
			}
			/*
			_baseConnection.connect(uri, 
					_conferenceParameters.username, 
					_conferenceParameters.role,
					_conferenceParameters.room, 
					_conferenceParameters.voicebridge, 
					_conferenceParameters.record, 
					_conferenceParameters.externUserID,
					_conferenceParameters.internalUserID);
			*/
			_baseConnection.connect.apply(null, new Array(uri).concat(connectParams));
		}
		
		public function disconnect(onUserCommand:Boolean):void {
			_baseConnection.disconnect(onUserCommand);
		}
		
		public function get userId():String
		{
			return _userId;
		}

		public function sendMessage(service:String, onSuccess:Function, onFailure:Function, message:Object=null):void {
			_baseConnection.sendMessage(service, onSuccess, onFailure, message);
		}
	}
}
