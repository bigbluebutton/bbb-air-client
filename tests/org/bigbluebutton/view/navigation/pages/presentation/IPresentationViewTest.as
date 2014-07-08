package org.bigbluebutton.view.navigation.pages.presentation
{
	import org.flexunit.asserts.assertTrue;
	
	public class IPresentationViewTest
	{		
		protected var instance:IPresentationView;
		
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
	}
}