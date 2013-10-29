package org.mconf.mobile.model
{
	import flash.net.NetConnection;
	
	import mx.collections.ArrayList;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class UserSession implements IUserSession
	{
		protected var _netconnection:NetConnection;
		
		public function UserSession()
		{
			
		}

		public function get netconnection():NetConnection
		{
			return _netconnection;
		}

		public function set netconnection(value:NetConnection):void
		{
			_netconnection = value;
		}

	}
}