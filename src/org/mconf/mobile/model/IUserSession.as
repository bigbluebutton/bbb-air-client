package org.mconf.mobile.model
{
	import flash.net.NetConnection;
	
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.IVideoConnection;
	import org.mconf.mobile.core.IVoiceConnection;
	import org.mconf.mobile.core.VideoConnection;
	import org.mconf.mobile.core.VoiceStreamManager;
	

	public interface IUserSession
	{
		function get netconnection():NetConnection;
		function set netconnection(value:NetConnection):void;
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
		function get videoConnection():IVideoConnection
		function set videoConnection(value:IVideoConnection):void
	}
}