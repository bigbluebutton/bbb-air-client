package org.bigbluebutton.view.navigation.pages.videochat
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class VideoChatViewBaseTest
	{		
		protected var instance:VideoChatViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new VideoChatViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfVideoChatViewBase():void
		{
			assertTrue("instance is VideoChatViewBase", instance is VideoChatViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}