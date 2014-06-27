package org.bigbluebutton.core.view
{
	import org.bigbluebutton.view.navigation.PagesNavigatorView;
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class IViewTest
	{		
		protected var instance:IView;
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new PagesNavigatorView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIView():void
		{
			assertTrue("instance is IView", instance is IView);
		}
	}
}