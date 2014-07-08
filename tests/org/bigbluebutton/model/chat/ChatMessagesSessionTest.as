package org.bigbluebutton.model.chat
{
	import org.flexunit.asserts.assertTrue;

	public class ChatMessagesSessionTest
	{		
		protected var instance:ChatMessagesSession;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatMessagesSession();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatMessagesSession():void
		{
		 	assertTrue("instance is ChatMessagesSession", instance is ChatMessagesSession);
		}
		
		[Test]
		public function instantiated_implementsIChatMessagesSessionInterface():void
		{
			assertTrue("instance implements IChatMessagesSession interface", instance is IChatMessagesSession);
		}
	}
}