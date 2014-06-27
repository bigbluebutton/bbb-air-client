package org.bigbluebutton.view.navigation.pages.videochat
{
	import org.flexunit.asserts.assertTrue;
	
	public class IVideoChatViewTest
	{		
		protected var instance:IVideoChatView;
		
		[Before]
		public function setUp():void
		{
			instance = new VideoChatView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfVideoChatView():void
		{
			assertTrue("instance is VideoChatView", instance is VideoChatView);
		}
	}
}
