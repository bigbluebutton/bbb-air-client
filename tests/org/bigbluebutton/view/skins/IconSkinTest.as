package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class IconSkinTest
	{		
		protected var instance:IconSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new IconSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIconSkin():void
		{
			assertTrue("instance is IconSkin", instance is IconSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}
