package org.mconf.mobile.core
{
	import flash.net.NetConnection;
	
	import org.osflash.signals.ISignal;
	
	public interface IBaseConnection
	{
		function get connection():NetConnection;
		function connect(uri:String, ...parameters):void;	
		function disconnect(onUserCommand:Boolean):void;
		
		function get unsuccessConnected():ISignal;
		function get successConnected():ISignal;
	}
}