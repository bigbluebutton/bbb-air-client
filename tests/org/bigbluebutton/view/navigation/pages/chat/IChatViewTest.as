package org.bigbluebutton.view.navigation.pages.chat
{
	import org.bigbluebutton.core.view.IView;
	import org.flexunit.asserts.assertTrue;
	
	public class IChatViewTest
	{		
		protected var instance:IChatView;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatView():void
		{
			assertTrue("instance is ChatView", instance is ChatView);
		}
		
		[Test]
		public function instantiated_implementsIView():void
		{
			assertTrue("instance implements IView", instance is IView);
		}
	}
}