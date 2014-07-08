package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.core.view.IView;
	import org.flexunit.asserts.assertTrue;
	
	public class INavigationButtonTest
	{		
		protected var instance:INavigationButton;
		
		[Before]
		public function setUp():void
		{
			instance = new NavigationButton();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfNavigationButton():void
		{
			assertTrue("instance is NavigationButton", instance is NavigationButton);
		}
		
		[Test]
		public function instantiated_implementsIView():void
		{
			assertTrue("instance implements IView", instance is IView);
		}
	}
}