package org.bigbluebutton.view.navigation.pages.disconnect
{
	import org.bigbluebutton.core.view.IView;
	import org.flexunit.asserts.assertTrue;
	
	public class IDisconnectPageViewTest
	{		
		protected var instance:IDisconnectPageView;
		
		[Before]
		public function setUp():void
		{
			instance = new DisconnectPageView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDisconnectPageView():void
		{
			assertTrue("instance is DisconnectPageView", instance is DisconnectPageView);
		}
	}
}