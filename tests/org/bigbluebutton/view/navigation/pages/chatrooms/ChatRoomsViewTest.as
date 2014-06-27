package org.bigbluebutton.view.navigation.pages.chatrooms
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class ChatRoomsViewTest
	{		
		protected var instance:ChatRoomsView;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatRoomsView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatRoomsView():void
		{
			assertTrue("instance is ChatRoomsView", instance is ChatRoomsView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIChatRoomsView():void
		{
			assertTrue("instance implements IChatRoomsView", instance is IChatRoomsView);
		}
	}
}
