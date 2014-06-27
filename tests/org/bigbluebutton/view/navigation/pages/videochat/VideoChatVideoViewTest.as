package org.bigbluebutton.view.navigation.pages.videochat
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class VideoChatVideoViewTest
	{		
		protected var instance:VideoChatVideoView;
		
		[Before]
		public function setUp():void
		{
			instance = new VideoChatVideoView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfVideoChatVideoView():void
		{
			assertTrue("instance is VideoChatVideoView", instance is VideoChatVideoView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}