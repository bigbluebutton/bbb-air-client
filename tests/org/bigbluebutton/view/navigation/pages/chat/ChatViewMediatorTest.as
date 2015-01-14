package org.bigbluebutton.view.navigation.pages.chat
{
	import flash.events.Event;
	
	import mockolate.expect;
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import mx.events.FlexEvent;
	
	import org.bigbluebutton.core.ChatMessageService;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.UserUISession;
	import org.bigbluebutton.model.chat.ChatMessages;
	import org.bigbluebutton.model.chat.ChatMessagesSession;
	import org.bigbluebutton.model.chat.PrivateChatMessage;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.TextInput;
	
	public class ChatViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		protected var instance:ChatViewMediator;

		
		/* Mocked fields */
		
		[Mock]
		public var mockView:ChatView;
		
		[Mock]
		public var mockChatMessageService:ChatMessageService;
		
		[Mock]
		public var mockUserSession:UserSession;
		
		[Mock]
		public var mockUserUISession:UserUISession;
		
		[Mock]
		public var mockChatMessagesSession:ChatMessagesSession;
		
		
		/* Other dependencies */
		
		[Mock]
		public var mockList:List;
		
		[Mock]
		public var mockSendButton:Button;
		
		[Mock]
		public var mockUserList:UserList;
		
		[Mock]
		public var mockPageName:Label;
		
		[Mock]
		public var mockInputMessage:TextInput; 
		
		[Mock]
		public var mockPrivateChat:PrivateChatMessage;
		
		[Mock]
		public var mockChatMessages:ChatMessages;
		
		
		/* Signals */
		
		public var mockSendMessageOnSuccessSignal:Signal = new Signal();
		
		public var mockSendMessageOnFailureSignal:Signal = new Signal();
		
		public var mockUserRemovedSignal:Signal = new Signal();
		
		public var mockUserAddedSignal:Signal  = new Signal();
				
		[Before]
		public function setUp():void
		{
			instance = new ChatViewMediator();
			
			/* Set up all of the mocked fields: */
			
			instance.chatMessageService = mockChatMessageService;
			instance.chatMessagesSession = mockChatMessagesSession;
			instance.userSession = mockUserSession;
			instance.userUISession = mockUserUISession;
			instance.view = mockView;
			
			/* String all of the other dependencies together: */
			
			stub(instance.chatMessageService).getter("sendMessageOnSuccessSignal").returns(mockSendMessageOnSuccessSignal);
			stub(instance.chatMessageService).getter("sendMessageOnFailureSignal").returns(mockSendMessageOnFailureSignal);
			
			stub(instance.userSession).getter("userList").returns(mockUserList);
			stub(mockUserList).getter("userRemovedSignal").returns(mockUserRemovedSignal);
			stub(mockUserList).getter("userAddedSignal").returns(mockUserAddedSignal);
			
			stub(mockChatMessagesSession).method("getPrivateMessages").anyArgs().returns(mockPrivateChat);
			stub(mockPrivateChat).getter("privateChat").returns(mockChatMessages);
			
			stub(mockView).getter("list").returns(mockList);
			stub(mockView).getter("inputMessage").returns(mockInputMessage);
			stub(mockView).getter("sendButton").returns(mockSendButton);
			stub(mockView).getter("pageName").returns(mockPageName);

			// mock(mockList).asEventDispatcher();
			// mock(mockSendButton).asEventDispatcher();
			stub(mockList).asEventDispatcher();
			stub(mockSendButton).asEventDispatcher();
		}
		
		[Test]
		public function initialize_currentPageDetailsIsUser_createNewPrivateChat():void
		{
			var user:User = new User();
			user.name = "User name";
			
			stub(mockUserUISession).getter("currentPageDetails").returns(user);
			instance.initialize();
		}
		
		/* The 'currentPageDetails' object, when it is not a user should contain at least 5 fields. They are:
		 * publicChat, user, name, chatMessages, online. 'online' only applies to private chat. */
		
		[Test]
		public function initialize_currentPageDetailsIsPublicChat_opensPublicChatMessages():void
		{
			var cpd:Object = new Object();
			cpd.publicChat = true;
			cpd.user = new User();
			cpd.name = "Mock Chat Name";
			cpd.chatMessages = new ChatMessages();
			
			stub(mockUserUISession).getter("currentPageDetails").returns(cpd);
			instance.initialize();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		
		
/*		[Test]
		public function instantiated_isInstanceOfChatViewMediator():void
		{
			assertTrue("instance is ChatViewMediator", instance is ChatViewMediator);
		}
		
		[Test]
		public function instantiated_isRobotlegsMediator():void
		{
			assertTrue("instance is Robotlegs Mediator", instance is Mediator);
		}
		
		[Test]
		public function destroyed_viewIsDestroyed():void
		{	
			// Arrange
			stub(instance.view).getter("sendButton").returns(this.sendButton);
			stub(instance.chatMessageService).getter("sendMessageOnSuccessSignal").returns(this.sendMessageOnSuccessSignal);
			stub(instance.chatMessageService).getter("sendMessageOnFailureSignal").returns(this.sendMessageOnFailureSignal);
			stub(instance.userSession).getter("userList").returns(this.userList);
			stub(instance.userSession.userList).getter("userAddedSignal").returns(this.userAddedSignal);
			stub(instance.userSession.userList).getter("userRemovedSignal").returns(this.userRemovedSignal);
			
			// Act
			instance.destroy();
			
			// Assert
			assertTrue("view is destroyed when mediator is destroyed", instance.view == null);
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}*/
	}
}