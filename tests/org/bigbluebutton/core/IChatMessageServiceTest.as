package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IChatMessageServiceTest
	{		
		protected var instance:IChatMessageService;
		
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
		public function instantiated_isInstanceOfIChatMessageService():void 
		{
			assertTrue("instance is IChatMessageService", instance is IChatMessageService);
		}
	}
}