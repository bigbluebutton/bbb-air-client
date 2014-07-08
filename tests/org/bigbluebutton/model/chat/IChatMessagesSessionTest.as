package org.bigbluebutton.model.chat
{
	import flash.utils.getQualifiedClassName;
	
	import org.flexunit.asserts.assertTrue;
	
	public class IChatMessagesSessionTest
	{		
		protected var instance:IChatMessagesSession;
		
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
		public function instantiated_isInstanceOfIChatMessagesSession():void
		{
			assertTrue("instance is IChatMessagesSession", instance is IChatMessagesSession);
		}
	}
}