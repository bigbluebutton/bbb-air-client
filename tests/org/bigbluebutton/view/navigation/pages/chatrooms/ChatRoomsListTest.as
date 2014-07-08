package org.bigbluebutton.view.navigation.pages.chatrooms
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.List;
	
	public class ChatRoomsListTest
	{		
		protected var instance:ChatRoomsList;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatRoomsList();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatRoomsList():void
		{
			assertTrue("instance is ChatRoomsList", instance is ChatRoomsList);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark List component", instance is List);
		}
	}
}
