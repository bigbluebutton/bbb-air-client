package org.bigbluebutton.view.navigation.pages.chat
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.bigbluebutton.core.ChatMessageService;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.UserUISession;
	import org.bigbluebutton.model.chat.ChatMessagesSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.Button;
	import spark.components.List;
	
	public class ChatViewMediatorTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var view:ChatView;
		
		[Mock]
		public var chatMessageService:ChatMessageService;
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var userUISession:UserUISession;
		
		[Mock]
		public var chatMessagesSession:ChatMessagesSession;
		
		[Mock]
		public var list:List;
		
		[Mock]
		public var sendButton:Button;
		
		[Mock]
		public var sendMessageOnSuccessSignal:Signal;
		
		[Mock]
		public var sendMessageOnFailureSignal:Signal;
		
		[Mock]
		public var userList:UserList;
		
		[Mock]
		public var userRemovedSignal:Signal;
		
		[Mock]
		public var userAddedSignal:Signal
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:ChatViewMediator;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(ChatView, ChatMessageService, UserSession, UserUISession, ChatMessagesSession, List, Button, Signal), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new ChatViewMediator();
			
			instance.chatMessageService = this.chatMessageService;
			instance.chatMessagesSession = this.chatMessagesSession;
			instance.userSession = this.userSession;
			instance.userUISession = this.userUISession;
			instance.view = this.view;
			instance.list = this.list;
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
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
		}
	}
}