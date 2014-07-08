package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class ChatMessageServiceTest
	{		
		protected var instance:ChatMessageService;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatMessageService();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatMessageService():void
		{
			assertTrue("instance is ChatMessageService", instance is ChatMessageService);
		}
		
		[Test]
		public function instantiated_implementsIChatMessageServiceInterface():void
		{
			assertTrue("instance implements IChatMessageService interface", instance is IChatMessageService);
		}
	}
}
