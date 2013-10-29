package org.mconf.mobile.model
{
	import flash.net.NetConnection;
	
	import org.osflash.signals.ISignal;

	public interface IUserSession
	{
		function get netconnection():NetConnection
		function set netconnection(value:NetConnection):void
	}
}