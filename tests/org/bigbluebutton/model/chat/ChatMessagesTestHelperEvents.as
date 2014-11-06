package org.bigbluebutton.model.chat
{
	import flash.events.Event;
	
	public class ChatMessagesTestHelperEvents extends Event
	{
		public static const CHAT_MESSAGES_SIGNAL_CORRECT:String = "CHAT_MESSAGES_SIGNAL_CORRECT";
		public static const CHAT_MESSAGES_RESET_SIGNAL_CORRECT:String = "CHAT_MESSAGES_RESET_SIGNAL_CORRECT";
		
		public function ChatMessagesTestHelperEvents(type:String):void
		{
			super(type);
		}
	}
}