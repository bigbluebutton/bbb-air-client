package org.bigbluebutton.model.chat
{
	import flash.events.Event;
	
	public class ChatMessagesSessionTestHelperEvents extends Event
	{
		public static const CHAT_MESSAGE_CHANGE_SIGNAL_CORRECT:String = "CHAT_MESSAGE_CHANGE_SIGNAL_CORRECT";
		
		public function ChatMessagesSessionTestHelperEvents(type:String):void
		{
			super(type);
		}
	}
}