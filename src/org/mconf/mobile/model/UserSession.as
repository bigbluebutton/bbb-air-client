package org.mconf.mobile.model
{
	import flash.net.NetConnection;
	
	import mx.collections.ArrayList;
	
	import org.hamcrest.core.throws;
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.IVideoConnection;
	import org.mconf.mobile.core.IVoiceConnection;
	import org.mconf.mobile.core.VoiceStreamManager;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class UserSession implements IUserSession
	{

		protected var _netconnection:NetConnection;
		protected var _config:Config;
		protected var _userId:String;
		protected var _mainConnection:IBigBlueButtonConnection;
		protected var _voiceConnection:IVoiceConnection;
		protected var _voiceStreamManager:VoiceStreamManager;
		protected var _videoConnection:IVideoConnection;
		protected var _userlist:UserList;
				
		public function get netconnection():NetConnection
		{
			return _netconnection;
		}
		
		public function set netconnection(value:NetConnection):void
		{
			_netconnection = value;
		}
		
		public function get userlist():UserList
		{
			return _userlist;
		}
		
		private function set userlist(value:UserList):void
		{
			throws("Don't allow manually setting the userlist");
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

		public function get voiceStreamManager():VoiceStreamManager
		{
			return _voiceStreamManager;
		}

		public function set voiceStreamManager(value:VoiceStreamManager):void
		{
			_voiceStreamManager = value;
		}

		public function get videoConnection():IVideoConnection
		{
			return _videoConnection;
		}

		public function set videoConnection(value:IVideoConnection):void
		{
			_videoConnection = value;
		}

		public function UserSession()
		{
			_userlist = new UserList();
		}
	}
}