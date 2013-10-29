package org.mconf.mobile.core
{
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	
	import org.mconf.mobile.model.IConferenceParameters;
	
	public interface IBigBlueButtonConnection
	{
		function set uri(uri:String):void;
		function get connection():NetConnection;
		function connect(params:IConferenceParameters, tunnel:Boolean = false):void;	
		function disconnect(logoutOnUserCommand:Boolean):void;
	}
}