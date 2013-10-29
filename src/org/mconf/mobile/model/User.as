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
		
		private var _role:String = VIEWER;
		[Bindable] 
		public function get role():String {
			return _role;
		}
		public function set role(role:String):void {
			_role = role;
			verifyUserStatus();
		}
		
		public function User()
		{
		}
		
		private function verifyUserStatus():void {
			
		}
	}
}