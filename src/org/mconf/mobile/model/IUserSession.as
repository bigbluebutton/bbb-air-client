package org.mconf.mobile.model
{
	import flash.net.NetConnection;
	
	import org.osflash.signals.ISignal;

	public interface IUserSession
	{
		function get netconnection():NetConnection;
		function set netconnection(value:NetConnection):void;
		function get config():Config;
		function set config(value:Config):void;
		function get userId():String;
		function set userId(value:String):void;		
	}
}