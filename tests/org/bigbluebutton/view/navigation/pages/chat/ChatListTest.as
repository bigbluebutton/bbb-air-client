package org.bigbluebutton.view.navigation.pages.chat
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.List;
	
	public class ChatListTest
	{		
		protected var instance:ChatList;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatList();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatList():void
		{
			assertTrue("instance is ChatList", instance is ChatList);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark List component", instance is List);
		}
	}
}