package org.mconf.mobile.model
{
	public class User
	{
		public static const MODERATOR:String = "MODERATOR";
		public static const VIEWER:String = "VIEWER";
		public static const PRESENTER:String = "PRESENTER";
		
		// Flag to tell that user is in the process of leaving the meeting.
		public var isLeavingFlag:Boolean = false;

		[Bindable] public var userID:String = "UNKNOWN USER";
		[Bindable] public var externUserID:String = "UNKNOWN USER";
		[Bindable] public var name:String;
		[Bindable] public var phoneUser:Boolean = false;
		[Bindable] public var me:Boolean = false;
		[Bindable] public var presenter:Boolean = false;
		
		private var _role:String = VIEWER;
		[Bindable] 
		public function get role():String {
			return _role;
		}
		public function set role(role:String):void {
			_role = role;
			verifyUserStatus();
		}
		
		private var _raiseHand:Boolean = false;
		[Bindable]
		public function get raiseHand():Boolean {
			return _raiseHand;
		}
		public function set raiseHand(r:Boolean):void {
			_raiseHand = r;
			verifyUserStatus();
		}
		
		private var _hasStream:Boolean = false;
		[Bindable]
		public function get hasStream():Boolean {
			return _hasStream;
		}
		public function set hasStream(s:Boolean):void {
			_hasStream = s;
			verifyMedia();
		}
		
		public var streamName:String = "";
		
		// This used to only be used for accessibility and doesn't need to be filled in yet. - Chad
		private function verifyUserStatus():void {
			
		}
		
		// This used to only be used for accessibility and doesn't need to be filled in yet. - Chad
		private function verifyMedia():void {
			
		}
	}
}