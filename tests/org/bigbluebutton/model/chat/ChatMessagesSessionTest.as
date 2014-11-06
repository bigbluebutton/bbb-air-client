package org.bigbluebutton.model.chat
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class ChatMessagesSessionTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		protected var instance:ChatMessagesSession;
		
		/* Event dispatcher for the helper event types, defined in the 'UserListTestHelperEvents' class. They are used
		 * to check that signals are dispatched, and with the right arguments, by putting listener methods on the
		 * signals that dispatch an event if all goes well. If the signal is not dispatched, the method will not be 
		 * invoked, and the test will timeout waiting for the event. If they are called, but with the wrong arguments,
		 * then the assertions within the listener method will fail. */
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			instance = new ChatMessagesSession();
		}
		
		/* ChatMessagesSession::addUserToPrivateMessages tests */
		
		[Test]
		public function addUserToPrivateMessages_userAddedToPrivateChat():void
		{
			instance.addUserToPrivateMessages("123", "ABC");
			var pm:PrivateChatMessage = instance.privateChats.getItemAt(0) as PrivateChatMessage;
			assertThat(pm.userID, equalTo("123"));
			assertThat(pm.userName, equalTo("ABC"));
		}
		
		/* ChatMessagesSession::newPrivateMessage tests */
		
		[Test]
		public function newPrivateMessage_fromNewUser_newUserAddedtoPrivateChatsList():void
		{
			assertThat(instance.privateChats.length, equalTo(0));
			var message:ChatMessageVO = createChatMessageVO("chat message text");
			instance.newPrivateMessage("123", "ABC", message);
			assertThat(instance.privateChats.length, equalTo(1));
			
			var pm:PrivateChatMessage = instance.privateChats.getItemAt(0) as PrivateChatMessage;
			assertThat(pm.userID, equalTo("123"));
			assertThat(pm.userName, equalTo("ABC"));
		}
		
		[Test]
		public function newPrivateMessage_fromNotNewUser_ChatMessagesFromThatUserAreUpdated():void
		{
			var message1:ChatMessageVO = createChatMessageVO("chat message text 1");
			instance.newPrivateMessage("123", "ABC", message1);
			var message2:ChatMessageVO = createChatMessageVO("chat message text 2");
			instance.newPrivateMessage("123", "ABC", message2);
			var message3:ChatMessageVO = createChatMessageVO("chat message text 3");
			instance.newPrivateMessage("123", "ABC", message3);
			
			assertThat(instance.privateChats.length, equalTo(1));
			
			var pm:PrivateChatMessage = instance.privateChats.getItemAt(0) as PrivateChatMessage;
			var cm:ChatMessages = pm.privateChat as ChatMessages;
			assertThat(cm.messages.getItemAt(0).senderText, equalTo("chat message text 1"));
			assertThat(cm.messages.getItemAt(1).senderText, equalTo("chat message text 2"));
			assertThat(cm.messages.getItemAt(2).senderText, equalTo("chat message text 3"));
		}
		
		[Test (async)]
		public function newPrivateMessage_dispatchesChatMessageChangeSignal():void
		{
			var message:ChatMessageVO = createChatMessageVO("chat message text");
			instance.chatMessageChangeSignal.add(chatMessageChangeSignalChecker);
			Async.proceedOnEvent(this, dispatcher, ChatMessagesSessionTestHelperEvents.CHAT_MESSAGE_CHANGE_SIGNAL_CORRECT, 5000);
			instance.newPrivateMessage("123", "ABC", message);
		}
		
		private function chatMessageChangeSignalChecker(userID:String):void
		{
			assertThat(userID, equalTo("123"));
			dispatcher.dispatchEvent(new ChatMessagesSessionTestHelperEvents(
										ChatMessagesSessionTestHelperEvents.CHAT_MESSAGE_CHANGE_SIGNAL_CORRECT));
		}
		
		/* ChatMessagesSession::getPrivateMessages tests */
		
		[Test]
		public function getPrivateChatMessages_userInList_returnsListOfChatMessagesFromThatUser():void
		{
			var message1:ChatMessageVO = createChatMessageVO("chat message text 1");
			instance.newPrivateMessage("123", "ABC", message1);
			var message2:ChatMessageVO = createChatMessageVO("chat message text 2");
			instance.newPrivateMessage("123", "ABC", message2);
			var message3:ChatMessageVO = createChatMessageVO("chat message text 3");
			instance.newPrivateMessage("123", "ABC", message3);
			
			var pm:PrivateChatMessage = instance.getPrivateMessages("123", "ABC");
			var cm:ChatMessages = pm.privateChat as ChatMessages;
			assertThat(cm.messages.getItemAt(0).senderText, equalTo("chat message text 1"));
			assertThat(cm.messages.getItemAt(1).senderText, equalTo("chat message text 2"));
			assertThat(cm.messages.getItemAt(2).senderText, equalTo("chat message text 3"));
		}
		
		[Test]
		public function getPrivateChatMessages_userNotInList_userAddedWithEmptyMessageList():void
		{
			assertThat(instance.privateChats.length, equalTo(0));
			var pm:PrivateChatMessage = instance.getPrivateMessages("123", "ABC");
			assertThat(instance.privateChats.length, equalTo(1));
			assertThat(pm.privateChat.messages.length, equalTo(0));
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
		
		/*
		[Test]
		public function instantiated_isInstanceOfChatMessagesSession():void
		{
		 	assertTrue("instance is ChatMessagesSession", instance is ChatMessagesSession);
		}
		
		[Test]
		public function instantiated_implementsIChatMessagesSessionInterface():void
		{
			assertTrue("instance implements IChatMessagesSession interface", instance is IChatMessagesSession);
		}*/
	}
}