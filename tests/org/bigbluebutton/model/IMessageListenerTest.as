package org.bigbluebutton.model
{
	import flash.events.Event;
	
	import mockolate.prepare;
	
	import org.bigbluebutton.core.ChatMessageReceiver;
	import org.bigbluebutton.model.chat.ChatMessagesSession;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	public class IMessageListenerTest
	{		
		[Mock]
		public var chatMessageSession:ChatMessagesSession;
		
		[Mock]
		public var userSession:UserSession;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:IMessageListener;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(UserSession, ChatMessagesSession), Event.COMPLETE, TIMEOUT, timeoutHandler);
			instance = new ChatMessageReceiver(userSession, chatMessageSession);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIMessageListener():void
		{
			assertTrue("instance is IMessageListener", instance is IMessageListener);
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}