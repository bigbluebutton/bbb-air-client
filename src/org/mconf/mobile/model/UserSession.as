package org.mconf.mobile.model
{
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.IVoiceConnection;
	
	public class UserSession implements IUserSession
	{
		protected var _config:Config;
		protected var _userId:String;
		protected var _mainConnection:IBigBlueButtonConnection;
		protected var _voiceConnection:IVoiceConnection;
		protected var _userlist:UserList;

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

		public function get voiceConnection():IVoiceConnection
		{
			return _voiceConnection;
		}

		public function set voiceConnection(value:IVoiceConnection):void
		{
			_voiceConnection = value;
		}

		public function get mainConnection():IBigBlueButtonConnection
		{
			return _mainConnection;
		}

		public function set mainConnection(value:IBigBlueButtonConnection):void
		{
			_mainConnection = value;
		}


	}
}