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
		
		[Mock]
		public var view:ChatRoomsView;
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var userUISession:UserUISession;
		
		[Mock]
		public var chatMessagesSession:ChatMessagesSession;
		
		[Mock]
		public var list:List;
		
		[Mock]
		public var userList:UserList;
		
		[Mock]
		public var userRemovedSignal:Signal;
		
		[Mock]
		public var userAddedSignal:Signal
		
		[Mock]
		public var publicChat:ChatMessages;
		
		[Mock]			
		public var chatMessageChangeSignal:Signal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:ChatRoomsViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(ChatRoomsView, UserSession, UserUISession, ChatMessagesSession, Signal, ChatMessages, List, UserList), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new ChatRoomsViewMediator();
			
			instance.chatMessagesSession = this.chatMessagesSession;
			instance.userSession = this.userSession;
			instance.userUISession = this.userUISession;
			instance.view = this.view;
			instance.list = this.list
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
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
		}
	}
}
