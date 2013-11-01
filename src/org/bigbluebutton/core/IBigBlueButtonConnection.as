package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.model.IConferenceParameters;
	import org.osflash.signals.ISignal;
	
	public interface IBigBlueButtonConnection
	{
		function set uri(uri:String):void;
		function get uri():String;
		function get connection():NetConnection;
		function connect(params:IConferenceParameters, tunnel:Boolean = false):void;	
		function disconnect(logoutOnUserCommand:Boolean):void;
		
		function get unsuccessConnected():ISignal;
		function get successConnected():ISignal;
		function get userId():String;
	}
}