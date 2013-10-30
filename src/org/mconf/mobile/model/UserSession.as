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
		
		public function get netconnection():NetConnection
		{
			return _netconnection;
		}
		
		public function set netconnection(value:NetConnection):void
		{
			_netconnection = value;
		}
		
		private var _userlist:UserList;

		public function get userlist():UserList
		{
			return _userlist;
		}
		
		// Don't allow manually setting the userlist
		private function set userlist(value:UserList):void {}

		
		public function UserSession()
		{
			_userlist = new UserList();
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