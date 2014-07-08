package org.bigbluebutton.view.navigation.pages.deskshare
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class DeskshareViewBaseTest
	{		
		protected var instance:DeskshareViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new DeskshareViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDeskshareViewBase():void
		{
			assertTrue("instance is DeskshareViewBase", instance is DeskshareViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}