package org.mconf.mobile.model
{
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.IVoiceConnection;
	import org.mconf.mobile.core.VoiceStreamManager;
	

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
		function get voiceStreamManager():VoiceStreamManager
		function set voiceStreamManager(value:VoiceStreamManager):void
	}
}