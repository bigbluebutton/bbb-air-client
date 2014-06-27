package org.bigbluebutton.model.chat
{
	import org.flexunit.asserts.assertTrue;

	public class ChatMessagesTest
	{		
		protected var instance:ChatMessages;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatMessages();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatMessages():void
		{
			assertTrue("instance is ChatMessages", instance is ChatMessages);
		}
	}
}