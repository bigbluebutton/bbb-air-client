package org.mconf.mobile.model
{
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.IVoiceConnection;
	

	public interface IUserSession
	{
		function get config():Config;
		function set config(value:Config):void;
		function get userId():String;
		function set userId(value:String):void;		
		function get userlist():UserList
		function get voiceConnection():IVoiceConnection
		function set voiceConnection(value:IVoiceConnection):void
		function get mainConnection():IBigBlueButtonConnection
		function set mainConnection(value:IBigBlueButtonConnection):void
	}
}