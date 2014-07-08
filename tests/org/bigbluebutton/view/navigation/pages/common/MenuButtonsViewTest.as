package org.bigbluebutton.view.navigation.pages.common
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class MenuButtonsViewTest
	{		
		protected var instance:MenuButtonsView;
		
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
			assertTrue("instance is MenuButtonsView", instance is MenuButtonsView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
		
		[Test]
		public function instantiated_implementsIMenuButtonsView():void
		{
			assertTrue("instance implements IMenuButtonsView", instance is IMenuButtonsView);
		}
	}
}