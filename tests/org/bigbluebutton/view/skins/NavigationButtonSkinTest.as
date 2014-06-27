package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class NavigationButtonSkinTest
	{		
		protected var instance:NavigationButtonSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new NavigationButtonSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfNavigationButtonSkin():void
		{
			assertTrue("instance is NavigationButtonSkin", instance is NavigationButtonSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}