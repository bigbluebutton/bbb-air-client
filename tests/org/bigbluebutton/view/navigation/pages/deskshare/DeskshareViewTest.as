package org.bigbluebutton.view.navigation.pages.deskshare
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class DeskshareViewTest
	{		
		protected var instance:DeskshareView;
		
		[Before]
		public function setUp():void
		{
			instance = new DeskshareView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDeskshareView():void
		{
			assertTrue("instance is DeskshareView", instance is DeskshareView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIDeskshareView():void
		{
			assertTrue("instance implements IDeskshareView", instance is IDeskshareView);
		}
	}
}
