package org.bigbluebutton.model.chat
{
	import flash.events.EventDispatcher;
	
	import org.bigbluebutton.util.ChatUtil;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class ChatMessagesTest
	{		
		protected var instance:ChatMessages;
		
		/* Event dispatcher for the helper event types, defined in the 'UserListTestHelperEvents' class. They are used
	 	 * to check that signals are dispatched, and with the right arguments, by putting listener methods on the
		 * signals that dispatch an event if all goes well. If the signal is not dispatched, the method will not be 
		 * invoked, and the test will timeout waiting for the event. If they are called, but with the wrong arguments,
		 * then the assertions within the listener method will fail. */
		public var dispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			instance = new ChatMessages();
		}
		
		/* ChatMessages::numMessages tests */
		
		[Test]
		public function numMessages_returnsNumberOfMessages():void
		{
			assertThat(instance.numMessages(), equalTo(0));
			instance.newChatMessage(createChatMessageVO("message 1"));
			instance.newChatMessage(createChatMessageVO("message 2"));
			instance.newChatMessage(createChatMessageVO("message 3"));
			assertThat(instance.numMessages(), equalTo(3));
		}
		
		/* ChatMessages::newChatMessage tests */
		
		[Test]
		public function newChatMessage_addsMessageToMessagesList():void
		{
			var message:ChatMessageVO = createChatMessageVO("chat message text");
			instance.newChatMessage(message);
			assertThat(instance.numMessages(), equalTo(1));
			
			var m:ChatMessage = instance.messages.getItemAt(0) as ChatMessage;
			
			assertThat(m.senderId , equalTo(message.fromUserID));
			
			assertThat(m.senderLanguage , equalTo(message.fromLang));
			assertThat(m.receiverLanguage, equalTo(ChatUtil.getUserLang()));
			
			assertThat(m.translatedText, equalTo(message.message));
			assertThat(m.senderText, equalTo(message.message));
			
			assertThat(m.name , equalTo(message.fromUsername));
			assertThat(m.senderColor, equalTo(message.fromColor));
			assertThat(m.translatedColor, equalTo(uint(message.fromColor)));
			
			assertThat(m.fromTime , equalTo(message.fromTime));
			assertThat(m.fromTimezoneOffset , equalTo(message.fromTimezoneOffset));
		}
		
		[Test]
		public function newChatMessage_newMessageAddedWithTime_timeStampCorrect():void
		{
			var message1:ChatMessageVO = createChatMessageVO("chat message text");
			var message2:ChatMessageVO = createChatMessageVO("chat message text");
			
			/* The number in 'fromTime' field is to represent the number of milliseconds since January 1, 1970 */
			message1.fromTime = 1234;
			message2.fromTime = 123456789101112;
			
			instance.newChatMessage(message1);
			instance.newChatMessage(message2);
			
			var m1:ChatMessage = instance.messages.getItemAt(0) as ChatMessage;
			var m2:ChatMessage = instance.messages.getItemAt(1) as ChatMessage;
			
			/* Verifies the format of the time stamp string. Should be "HOUR:MINUTE" */
			var testDate1:Date = new Date();
			testDate1.setTime(1234);
			assertThat(m1.time, equalTo(ChatUtil.getHours(testDate1) + ":" + ChatUtil.getMinutes(testDate1)));
			
			var testDate2:Date = new Date();
			testDate2.setTime(123456789101112);
			assertThat(m2.time, equalTo(ChatUtil.getHours(testDate2) + ":" + ChatUtil.getMinutes(testDate2)));
		}
		
		[Test (async)]
		public function newChatMessage_dispatchesChatMessageChangeSignal():void
		{
			var message:ChatMessageVO = createChatMessageVO("chat message text");
			message.fromUserID = "123";
			instance.chatMessageChangeSignal.add(chatMessageChangeSignalChecker);
			Async.proceedOnEvent(this, dispatcher, ChatMessagesTestHelperEvents.CHAT_MESSAGES_SIGNAL_CORRECT, 5000);
			instance.newChatMessage(message);
		}
		
		private function chatMessageChangeSignalChecker(userID:String):void
		{
			assertThat(userID, equalTo("123"));
			dispatcher.dispatchEvent(new ChatMessagesTestHelperEvents(ChatMessagesTestHelperEvents.CHAT_MESSAGES_SIGNAL_CORRECT));
		}
		
		[Test]
		public function newChatMessage_chatMessageAdded_lastSenderIdSet():void
		{
			var message1:ChatMessageVO = createChatMessageVO("chat message text");
			message1.fromUserID = "AAA";
			instance.newChatMessage(message1);
			
			var message2:ChatMessageVO = createChatMessageVO("chat message text");
			message2.fromUserID = "BBB";
			instance.newChatMessage(message2);
			
			var m:ChatMessage = instance.messages.getItemAt(1) as ChatMessage;
			assertThat(m.lastSenderId, equalTo("AAA"));
		}
		
		[Test]
		public function newChatMessage_firstChatMessage_lastSenderIdIsEmptyString():void
		{
			var message:ChatMessageVO = createChatMessageVO("chat message text");
			instance.newChatMessage(message);
			var m:ChatMessage = instance.messages.getItemAt(0) as ChatMessage;
			assertThat(m.lastSenderId, equalTo(""));
		}
		
		/* ChatMessages::getAllMessageAsString tests */
		
			/* I don't think this is used anywhere... maybe remove this method? What is its purpose?? */
		
		
		
		/* ChatMessages::resetNewMessages tests */
		
		[Test (async)]
		public function resetNewMessages_dispatchesChatMessageChangeSignal():void
		{
			instance.chatMessageChangeSignal.add(chatMessageChangeOnResetSignalChecker);
			Async.proceedOnEvent(this, dispatcher, ChatMessagesTestHelperEvents.CHAT_MESSAGES_RESET_SIGNAL_CORRECT, 5000);
			instance.resetNewMessages();
		}
		
		private function chatMessageChangeOnResetSignalChecker(userID:String):void
		{
			assertThat(userID, equalTo(null));
			assertThat(instance.newMessages, equalTo(0));
			dispatcher.dispatchEvent(new ChatMessagesTestHelperEvents(ChatMessagesTestHelperEvents.CHAT_MESSAGES_RESET_SIGNAL_CORRECT));
		}
		
		/* helpers */
		
		private function createChatMessageVO(text:String):ChatMessageVO
		{
			var chatMessageVO:ChatMessageVO = new ChatMessageVO;
			chatMessageVO.message = text; 
			
			chatMessageVO.fromUserID = "sender ID";
			chatMessageVO.fromUsername = "sender name";
			chatMessageVO.toUserID = "receiver ID";
			chatMessageVO.toUsername = "receiver name";
			chatMessageVO.chatType = "public";
			chatMessageVO.fromColor = "0x000000";
			chatMessageVO.fromTime = 0;
			chatMessageVO.fromLang = "language";
			chatMessageVO.fromTimezoneOffset = 0;
			
			return chatMessageVO;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
/*		[Test]
		public function instantiated_isInstanceOfChatMessages():void
		{
			assertTrue("instance is ChatMessages", instance is ChatMessages);
		}*/
	}
}