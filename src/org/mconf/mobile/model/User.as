package org.mconf.mobile.model
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class User
	{
		public static const MODERATOR:String = "MODERATOR";
		public static const VIEWER:String = "VIEWER";
		public static const PRESENTER:String = "PRESENTER";
		
		// Flag to tell that user is in the process of leaving the meeting.
		public var isLeavingFlag:Boolean = false;

		private var _userID:String = "UNKNOWN USER";

		public function get userID():String
		{
			return _userID;
		}

		public function set userID(value:String):void
		{
			_userID = value;
			change();
		}

		
		private var _externUserID:String = "UNKNOWN USER";

		public function get externUserID():String
		{
			return _externUserID;
		}

		public function set externUserID(value:String):void
		{
			_externUserID = value;
			change();
		}

		
		private var _name:String;

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
			change();
		}

		
		private var _phoneUser:Boolean = false;

		public function get phoneUser():Boolean
		{
			return _phoneUser;
		}

		public function set phoneUser(value:Boolean):void
		{
			_phoneUser = value;
			change();
		}

		
		private var _me:Boolean = false;

		public function get me():Boolean
		{
			return _me;
		}

		public function set me(value:Boolean):void
		{
			_me = value;
			change();
		}

		
		private var _presenter:Boolean = false;

		public function get presenter():Boolean
		{
			return _presenter;
		}

		public function set presenter(value:Boolean):void
		{
			_presenter = value;
			change();
		}

		
		private var _role:String = VIEWER;

		public function get role():String {
			return _role;
		}
		
		public function set role(role:String):void {
			_role = role;
			verifyUserStatus();
			change();
		}
		
		private var _raiseHand:Boolean = false;

		public function get raiseHand():Boolean {
			return _raiseHand;
		}
		public function set raiseHand(r:Boolean):void {
			_raiseHand = r;
			verifyUserStatus();
			change();
		}
		
		private var _hasStream:Boolean = false;
		[Bindable]
		public function get hasStream():Boolean {
			return _hasStream;
		}
		public function set hasStream(s:Boolean):void {
			_hasStream = s;
			verifyMedia();
			change();
		}
		
		private function change():void
		{
			if(_signal)
			{
				_signal.dispatch(this);
			}
		}
		
		public var streamName:String = "";
		
		// This used to only be used for accessibility and doesn't need to be filled in yet. - Chad
		private function verifyUserStatus():void {
			
		}
		
		// This used to only be used for accessibility and doesn't need to be filled in yet. - Chad
		private function verifyMedia():void {
			
		}
		
		private var _signal:ISignal;

		public function get signal():ISignal {
			return _signal;
		}
		public function set signal(signal:ISignal):void {
			_signal = signal;
		}
	}
}