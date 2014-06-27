package org.bigbluebutton.view.navigation.pages.common
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class MenuButtonsTest
	{		
		protected var instance:MenuButtons;
		
		[Before]
		public function setUp():void
		{
			instance = new MenuButtons();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfMenuButtons():void
		{
			assertTrue("instance is MenuButtons", instance is MenuButtons);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}