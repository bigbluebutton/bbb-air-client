package org.bigbluebutton.view.ui
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Button;
	
	public class NavigationButtonTest
	{		
		protected var instance:NavigationButton;
		
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
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Button component", instance is Button);
		}
		
		[Test]
		public function instantiated_implementsINavigationButton():void
		{
			assertTrue("instance implements INavigationButton", instance is INavigationButton);
		}
	}
}