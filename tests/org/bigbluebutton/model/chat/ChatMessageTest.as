package org.bigbluebutton.model.chat
{
	import org.flexunit.asserts.assertTrue;

	public class ChatMessageTest
	{		
		protected var instance:ChatMessage;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatMessage();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatMessage():void
		{
			assertTrue("instance is ChatMessage", instance is ChatMessage);
		}
	}
}