package org.bigbluebutton.model
{
	import flash.events.Event;
	
	public class UserUISessionTestHelperEvents extends Event
	{
		public static const PUSH_PAGE_SIGNAL_CORRECT:String = "PUSH_PAGE_SIGNAL_CORRECT";
		public static const POP_PAGE_SIGNAL_CORRECT:String = "POP_PAGE_SIGNAL_CORRECT";
		public static const LOADING_SIGNAL_CORRECT:String = "LOADING_SIGNAL_CORRECT";
		
		public function UserUISessionTestHelperEvents(type:String):void
		{
			super(type);
		}
	}
}