package org.mconf.mobile.model
{
	import flash.net.NetConnection;
	
	import mx.collections.ArrayList;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class UserSession implements IUserSession
	{
		protected var _netconnection:NetConnection;
		protected var _config:Config;
		protected var _userId:String;
		
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

		public function get config():Config
		{
			return _config;
		}
		
		public function set config(value:Config):void
		{
			_config = value;
		}

		public function get userId():String
		{
			return _userId;
		}

		public function set userId(value:String):void
		{
			_userId = value;
		}

	}
}