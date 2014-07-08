package org.bigbluebutton.view.navigation.pages.presentation
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class PresentationViewTest
	{		
		protected var instance:PresentationView;
		
		[Before]
		public function setUp():void
		{
			instance = new PresentationView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPresentationView():void
		{
			assertTrue("instance is PresentationView", instance is PresentationView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIPresentationView():void
		{
			assertTrue("instance implements IPresentationView", instance is IPresentationView);
		}
	}
}
