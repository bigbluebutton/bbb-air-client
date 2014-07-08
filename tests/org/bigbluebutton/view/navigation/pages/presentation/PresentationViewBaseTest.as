package org.bigbluebutton.view.navigation.pages.presentation
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class PresentationViewBaseTest
	{		
		protected var instance:PresentationViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new PresentationViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPresentationViewBase():void
		{
			assertTrue("instance is PresentationViewBase", instance is PresentationViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}
