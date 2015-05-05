package org.bigbluebutton.core {
	
	import flash.net.NetConnection;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IMessageListener;
	import org.osflash.signals.ISignal;
	
	public interface IBigBlueButtonConnection {
		function set uri(uri:String):void;
		function get uri():String;
		function get connection():NetConnection;
		function connect(params:IConferenceParameters, tunnel:Boolean = false):void;
		function disconnect(logoutOnUserCommand:Boolean):void;
		function sendMessage(service:String, onSuccess:Function, onFailure:Function, message:Object = null):void;
		function get unsuccessConnected():ISignal;
		function get successConnected():ISignal;
		function get userId():String;
		function addMessageListener(listener:IMessageListener):void
		function removeMessageListener(listener:IMessageListener):void
	}
}
