package org.bigbluebutton.model
{
	public class LockSettings
	{
		private var _disableCam:Boolean;
		private var _disableMic:Boolean;
		private var _disablePrivateChat:Boolean;
		private var _disablePublicChat:Boolean;
		private var _lockedLayout:Boolean;
		
		public function LockSettings(disableCam:Boolean, disableMic:Boolean, disablePrivateChat:Boolean, disablePublicChat:Boolean, lockLayout: Boolean)
		{
			_disableCam = disableCam;
			_disableMic = disableMic;
			_disablePrivateChat = disablePrivateChat;
			_disablePublicChat = disablePublicChat;
			_lockedLayout = lockLayout;
		}
		
		public function get disableCam():Boolean {
			return _disableCam;
		}
		
		public function get disableMic():Boolean {
			return _disableMic;
		}
		
		public function get disablePrivateChat():Boolean {
			return _disablePrivateChat;
		}
		
		public function get disablePublicChat():Boolean {
			return _disablePublicChat;
		}
		
		public function get lockedLayout():Boolean {
			return _lockedLayout;
		}
	}
}