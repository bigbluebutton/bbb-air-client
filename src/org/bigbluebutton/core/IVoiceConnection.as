package org.bigbluebutton.core {
	
	import flash.net.NetConnection;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.osflash.signals.ISignal;
	
	public interface IVoiceConnection {
		function get unsuccessConnected():ISignal
		function get successConnected():ISignal
		function set uri(uri:String):void
		function get uri():String
		function get connection():NetConnection
		function get callActive():Boolean
		function connect(confParams:IConferenceParameters):void
		function disconnect(onUserCommand:Boolean):void
		function failedToJoinVoiceConferenceCallback(msg:String):*
		function disconnectedFromJoinVoiceConferenceCallback(msg:String):*
		function successfullyJoinedVoiceConferenceCallback(publishName:String, playName:String, codec:String):*
		function call(listenOnly:Boolean = false):void
		function hangUp():void
	}
}
