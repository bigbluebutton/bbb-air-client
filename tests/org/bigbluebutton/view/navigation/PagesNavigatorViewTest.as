package org.bigbluebutton.view.navigation
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.ViewNavigator;
	
	public class PagesNavigatorViewTest
	{		
		protected var instance:PagesNavigatorView;
		
		[Before]
		public function setUp():void
		{
			instance = new PagesNavigatorView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPagesNavigatorView():void
		{
			assertTrue("instance is PagesNavigatorView", instance is PagesNavigatorView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark ViewNavigator component", instance is ViewNavigator);
		}
		
		[Test]
		public function instantiated_implementsIPagesNavigatorView():void
		{
			assertTrue("instance implements IPagesNavigatorView", instance is IPagesNavigatorView);
		}
	}
}
