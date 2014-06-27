package org.bigbluebutton.model.chat
{
	import org.flexunit.asserts.assertTrue;
	
	public class ChatMessageVOTest
	{		
		protected var instance:ChatMessageVO;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatMessageVO();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatMessageVO():void
		{
			assertTrue("instance is ChatMessageVO", instance is ChatMessageVO);
		}
	}
}