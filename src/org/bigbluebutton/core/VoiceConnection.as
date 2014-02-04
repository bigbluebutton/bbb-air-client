package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.model.IConferenceParameters;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;
	
	public class VoiceConnection extends DefaultConnectionCallback implements IVoiceConnection
	{
		public static const NAME:String = "VoiceConnection";
		
		protected var _successConnected:ISignal = new Signal();
		protected var _unsuccessConnected:ISignal = new Signal();
		
		protected var _baseConnection:BaseConnection;
		protected var _applicationURI:String;
		protected var _conferenceParameters:IConferenceParameters;
		protected var _username:String;
		
		public function VoiceConnection() {
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
			call(_conferenceParameters.webvoiceconf);
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
		
		public function connect(params:IConferenceParameters):void {
			// we don't use scope in the voice communication (many hours lost on it)
			var uri:String = _applicationURI;
			_conferenceParameters = params;
			_username = encodeURIComponent(params.externUserID + "-bbbID-" + params.username);
				
			_baseConnection.connect(uri, 
					params.externUserID,
					_username);
		}
		
		public function disconnect(onUserCommand:Boolean):void {
			_baseConnection.disconnect(onUserCommand);
		}
		
		//**********************************************//
		//												//
		//			CallBack Methods from Red5			//
		//												//
		//**********************************************//

		public function failedToJoinVoiceConferenceCallback(msg:String):* {
			trace(NAME + "::failedToJoinVoiceConferenceCallback(): " + msg);
			unsuccessConnected.dispatch("Failed on failedToJoinVoiceConferenceCallback()");
		}
		
		public function disconnectedFromJoinVoiceConferenceCallback(msg:String):* {
			trace(NAME + "::disconnectedFromJoinVoiceConferenceCallback(): " + msg);
			unsuccessConnected.dispatch("Failed on disconnectedFromJoinVoiceConferenceCallback()");
		}	
		
		public function successfullyJoinedVoiceConferenceCallback(publishName:String, playName:String, codec:String):* {
			trace(NAME + "::successfullyJoinedVoiceConferenceCallback()");
			successConnected.dispatch(publishName, playName, codec);
		}
		
		//**********************************************//
		//												//
		//					SIP Actions					//
		//												//
		//**********************************************//

		public function call(webvoiceconf:String):void
		{
			var restoreFunctionName:String = "voiceconf.call";
			
			_baseConnection.connection.call(
				restoreFunctionName,
				new Responder(callOnSucess, callUnsucess),
				"default",
				_username,
				webvoiceconf
			);
		}
		
		private function callOnSucess(result:Object):void
		{
			trace("call success: " + ObjectUtil.toString(result));
		}
		
		private function callUnsucess(status:Object):void
		{
			trace("call error: " + ObjectUtil.toString(status));
			unsuccessConnected.dispatch("Failed on call()");
		}
		
		public function hangUp():void {
			var restoreFunctionName:String = "voiceconf.hangup";
			
			_baseConnection.connection.call(
				restoreFunctionName,
				new Responder(hangUpOnSucess, hangUpUnsucess),
				"default"
			);
		}
		
		private function hangUpOnSucess(result:Object):void
		{
			trace("call success: " + ObjectUtil.toString(result));
		}
		
		private function hangUpUnsucess(status:Object):void
		{
			trace("call error: " + ObjectUtil.toString(status));
		}
	}
}
