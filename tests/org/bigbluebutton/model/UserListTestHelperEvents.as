package org.bigbluebutton.model
{
	import flash.events.Event;
	
	public class UserListTestHelperEvents extends Event
	{
		public static const HAS_STREAM:String = "HAS_STREAM";
		public static const PRESENTER:String = "PRESENTER";
		public static const RAISE_HAND:String = "RAISE_HAND";
		public static const LISTEN_ONLY:String = "LISTEN_ONLY";
		public static const USER_ADDED:String = "USER_ADDED";
		public static const USER_REMOVED:String = "USER_REMOVED";
		public static const REMOVED_PRESENTER:String = "REMOVED_PRESENTER";
		public static const ASSIGN_PRESENTER:String = "ASSIGN_PRESENTER";
		public static const STREAM_CHANGE:String = "STREAM_CHANGE_HAS_STREAM";
		public static const RAISE_HAND_CHANGE:String = "RAISE_HAND_CHANGE"; 
		public static const JOIN_AUDIO:String = "JOIN_AUDIO";
		public static const LEAVE_AUDIO:String = "LEAVE_AUDIO";
		public static const MUTE_CHANGE:String = "MUTE_CHANGE";
		public static const LISTEN_ONLY_CHANGE:String = "LISTEN_ONLY_CHANGE";
		
		
		public function UserListTestHelperEvents(type:String):void
		{
			super(type);
		}
	}
}