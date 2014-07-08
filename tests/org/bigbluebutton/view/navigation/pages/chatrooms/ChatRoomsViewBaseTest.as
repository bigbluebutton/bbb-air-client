package org.bigbluebutton.view.navigation.pages.chatrooms
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class ChatRoomsViewBaseTest
	{		
		protected var instance:ChatRoomsViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatRoomsViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatRoomsViewBase():void
		{
			assertTrue("instance is ChatRoomsViewBase", instance is ChatRoomsViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}