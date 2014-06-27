package org.bigbluebutton.view.navigation.pages.common
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class VideoViewTest
	{		
		protected var instance:VideoView;
		
		[Before]
		public function setUp():void
		{
			instance = new VideoView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfVideoView():void
		{
			assertTrue("instance is VideoView", instance is VideoView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}