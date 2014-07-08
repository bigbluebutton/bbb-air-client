package org.bigbluebutton.view.navigation.pages.deskshare
{
	import org.bigbluebutton.view.navigation.pages.common.VideoView;
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class DeskshareVideoViewTest
	{		
		protected var instance:DeskshareVideoView;
		
		[Before]
		public function setUp():void
		{
			instance = new DeskshareVideoView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDeskshareVideoView():void
		{
			assertTrue("instance is DeskshareVideoView", instance is DeskshareVideoView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
		
		[Test]
		public function instantiated_extendsVideoView():void
		{
			assertTrue("instance extends VideoView", instance is VideoView);
		}
	}
}