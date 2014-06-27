package org.bigbluebutton.view.navigation
{
	import org.flexunit.asserts.assertTrue;
	
	public class IPagesNavigatorViewTest
	{		
		protected var instance:IPagesNavigatorView;
		
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
	}
}
