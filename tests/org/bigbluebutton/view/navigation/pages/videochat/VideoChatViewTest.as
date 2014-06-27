package org.bigbluebutton.view.navigation.pages.videochat
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class VideoChatViewTest
	{		
		protected var instance:VideoChatView;
		
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
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIVideoChatView():void
		{
			assertTrue("instance implements IVideoChatView", instance is IVideoChatView);
		}
	}
}