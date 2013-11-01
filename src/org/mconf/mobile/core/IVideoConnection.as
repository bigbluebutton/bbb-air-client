package org.mconf.mobile.core
{
	import flash.net.NetConnection;
	
	import org.osflash.signals.ISignal;

	public interface IVideoConnection
	{
		function get unsuccessConnected():ISignal
		function get successConnected():ISignal
		function set uri(uri:String):void
		function get uri():String
		function get connection():NetConnection
		function connect():void 
	}
}