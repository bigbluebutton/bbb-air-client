package org.bigbluebutton.view.ui
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class VideoTest
	{		
		protected var instance:Video;
		
		[Before]
		public function setUp():void
		{
			instance = new Video();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		// TODO : addChild in the Video constructor throws the exception, need to investigate
		
		[Ignore]
		[Test]
		public function instantiated_isInstanceOfVideo():void
		{
			assertTrue("instance is Video", instance is Video);
		}
		
		[Ignore]
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}