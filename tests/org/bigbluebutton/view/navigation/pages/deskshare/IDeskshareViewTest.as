package org.bigbluebutton.view.navigation.pages.deskshare
{
	import org.bigbluebutton.core.view.IView;
	import org.flexunit.asserts.assertTrue;
	
	public class IDeskshareViewTest
	{		
		protected var instance:IDeskshareView;
		
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
	}
}
