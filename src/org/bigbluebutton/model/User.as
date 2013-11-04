package org.bigbluebutton.model
{
	import org.bigbluebutton.command.MicrophoneEnableSignal;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class User
	{
		[Inject]
		public var microphoneEnableSignal: MicrophoneEnableSignal;
		
		public static const MODERATOR:String = "MODERATOR";
		public static const VIEWER:String = "VIEWER";
		public static const PRESENTER:String = "PRESENTER";
		
		/**
		 * Flag to tell that user is in the process of leaving the meeting.
		 */ 
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
		
		private var _voiceUserId:Number;
		public function get voiceUserId():Number
		{
			return _voiceUserId;
		}
		
		public function set voiceUserId(value:Number):void
		{
			_voiceUserId = value;
		}
		
		private var _voiceJoined:Boolean;
		[Bindable]
		public function get voiceJoined():Boolean
		{
			return _voiceJoined;
		}
		
		public function set voiceJoined(value:Boolean):void
		{
			_voiceJoined = value;
			verifyUserStatus();
			change();
		}
		
		private var _muted:Boolean;
		[Bindable]
		public function get muted():Boolean
		{
			return _muted;
		}		
		public function set muted(value:Boolean):void
		{
			_muted = value;
			
			//TODO hack here, please do it in the proper place
			// the following code isn't working, sometimes microphoneEnableSignal is null <o>
//			if (_me) {
//				microphoneEnableSignal.dispatch(!_muted, false);
//			}
			
			verifyUserStatus();
			change();
		}
		
		private var _talking:Boolean;
		[Bindable]
		public function get talking():Boolean
		{
			return _talking;
		}
		public function set talking(value:Boolean):void
		{
			_talking = value;
			verifyUserStatus();
			change();
		}
		
		private var _locked:Boolean;
		[Bindable]
		public function get locked():Boolean
		{
			return _locked;
			verifyUserStatus();
			change();
		}
		public function set locked(value:Boolean):void
		{
			_locked = value;
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