package org.bigbluebutton.view.navigation
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.ViewNavigator;
	
	public class PagesNavigatorViewBaseTest
	{		
		protected var instance:PagesNavigatorViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new PagesNavigatorViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPagesNavigatorViewBase():void
		{
			assertTrue("instance is PagesNavigatorViewBase", instance is PagesNavigatorViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark ViewNavigator component", instance is ViewNavigator);
		}
	}
}