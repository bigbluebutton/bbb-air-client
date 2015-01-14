package org.bigbluebutton.view.navigation.pages.chatrooms
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.core.IChatMessageService;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.UserUISession;
	import org.bigbluebutton.model.chat.ChatMessages;
	import org.bigbluebutton.model.chat.ChatMessagesSession;
	import org.bigbluebutton.model.chat.IChatMessagesSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.Button;
	import spark.components.List;
	
	public class ChatRoomsViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		protected var instance:ChatRoomsViewMediator;

		
		/* Mocked fields */
		
		[Mock]
		public var mockView:ChatRoomsView;
		
		[Mock]
		public var mockUserSession:UserSession;
		
		[Mock]
		public var mockChatMessagesSession:ChatMessagesSession;
		
		[Mock]
		public var mockUserUISession:UserUISession;
		
		
		/* Other dependencies */
		
		[Mock]
		public var mockPublicChat:ChatMessages;
		
		[Mock]
		public var mockList:List;
		
		[Mock]
		public var mockUserList:UserList;
		
		
		/* Signals */
		
		public var mockChatMessageChangeSignal:Signal = new Signal();
		
		public var publicChat_mockChatMessageChangeSignal:Signal = new Signal();
		
		public var mockUserRemovedSignal:Signal = new Signal();
		
		public var mockUserAddedSignal:Signal = new Signal();
		
		
		[Before]
		public function setUp():void
		{
			instance = new ChatRoomsViewMediator();
			
			/* Set up all of the mocked fields: */
			
			instance.chatMessagesSession = mockChatMessagesSession;
			instance.userSession = mockUserSession;
			instance.userUISession = mockUserUISession;
			instance.view = mockView;
				
			/* String all of the other dependencies together: */
			
			stub(mockUserSession).getter("userList").returns(mockUserList);
			stub(mockUserList).getter("userAddedSignal").returns(mockUserAddedSignal);
			stub(mockUserList).getter("userRemovedSignal").returns(mockUserRemovedSignal);
			
			stub(mockChatMessagesSession).getter("chatMessageChangeSignal").returns(mockChatMessageChangeSignal);
			stub(mockChatMessagesSession).getter("publicChat").returns(mockPublicChat);
			stub(mockPublicChat).getter("chatMessageChangeSignal").returns(publicChat_mockChatMessageChangeSignal);
			
			stub(mockView).getter("list").returns(mockList);
			stub(mockList).asEventDispatcher();
		}
		
		[Test]
		public function initialize():void
		{
			
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
/*		[Test]
		public function instantiated_isInstanceOfChatRoomsViewMediator():void
		{
			assertTrue("instance is ChatRoomsViewMediator", instance is ChatRoomsViewMediator);
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
			stub(instance.chatMessagesSession).getter("publicChat").returns(this.publicChat);
			stub(instance.chatMessagesSession.publicChat).getter("chatMessageChangeSignal").returns(this.chatMessageChangeSignal);
			stub(instance.userSession).getter("userList").returns(this.userList);
			stub(instance.userSession.userList).getter("userAddedSignal").returns(this.userAddedSignal);
			stub(instance.userSession.userList).getter("userRemovedSignal").returns(this.userRemovedSignal);
			stub(instance.chatMessagesSession).getter("chatMessageChangeSignal").returns(this.chatMessageChangeSignal);
			
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
