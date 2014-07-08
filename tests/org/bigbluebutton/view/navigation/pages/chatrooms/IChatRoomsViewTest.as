package org.bigbluebutton.view.navigation.pages.chatrooms
{
	import org.bigbluebutton.core.view.IView;
	import org.flexunit.asserts.assertTrue;
	
	public class IChatRoomsViewTest
	{		
		protected var instance:IChatRoomsView;
		
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
		public function instantiated_implementsIView():void
		{
			assertTrue("instance implements IView", instance is IView);
		}
	}
}