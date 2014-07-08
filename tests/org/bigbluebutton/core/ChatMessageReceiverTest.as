package org.bigbluebutton.core
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.chat.ChatMessagesSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	public class ChatMessageReceiverTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var chatMessagesSession:ChatMessagesSession;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:ChatMessageReceiver;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(UserSession, ChatMessagesSession), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new ChatMessageReceiver(userSession, chatMessagesSession);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatMessageReceiver():void
		{
			assertTrue("instance is ChatMessageReceiver", instance is ChatMessageReceiver);
		}
		
		[Test]
		public function instantiated_implementsIMessageListenerInterface():void
		{
			assertTrue("instance implements IMessageListener interface", instance is IMessageListener);
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}