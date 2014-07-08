package org.bigbluebutton.core
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	
	import org.bigbluebutton.model.UserSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	
	public class ChatMessageSenderTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock]
		public var userSession:UserSession;
		
		[Mock]
		public var successSendMessageSignal:Signal;
		
		[Mock]
		public var failureSendingMessageSignal:Signal;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:ChatMessageSender;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(UserSession, Signal), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new ChatMessageSender(userSession, successSendMessageSignal, failureSendingMessageSignal);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatMessageSender():void
		{
			assertTrue("instance is ChatMessageSender", instance is ChatMessageSender);
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}