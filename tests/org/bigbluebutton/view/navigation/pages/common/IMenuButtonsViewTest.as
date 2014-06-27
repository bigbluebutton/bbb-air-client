package org.bigbluebutton.view.navigation.pages.common
{
	import org.flexunit.asserts.assertTrue;
	
	public class IMenuButtonsViewTest
	{		
		protected var instance:IMenuButtonsView;
		
		[Before]
		public function setUp():void
		{
			instance = new MenuButtonsView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfMenuButtonsView():void
		{
			assertTrue("instance is IMenuButtonsView", instance is IMenuButtonsView);
		}
	}
}