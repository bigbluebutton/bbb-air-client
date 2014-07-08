package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class TopButtonSkinTest
	{		
		protected var instance:TopButtonSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new TopButtonSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfTopButtonSkin():void
		{
			assertTrue("instance is TopButtonSkin", instance is TopButtonSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}