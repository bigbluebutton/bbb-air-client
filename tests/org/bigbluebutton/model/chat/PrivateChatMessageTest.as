package org.bigbluebutton.model.chat
{
	import org.flexunit.asserts.assertTrue;
	
	public class PrivateChatMessageTest
	{		
		protected var instance:PrivateChatMessage;
		
		[Before]
		public function setUp():void
		{
			instance = new PrivateChatMessage();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPrivateChatMessage():void
		{
			assertTrue("instance is PrivateChatMessage", instance is PrivateChatMessage);
		}
	}
}