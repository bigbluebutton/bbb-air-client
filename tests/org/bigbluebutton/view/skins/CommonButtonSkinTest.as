package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class CommonButtonSkinTest
	{		
		protected var instance:CommonButtonSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new CommonButtonSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfCommonButtonSkin():void
		{
			assertTrue("instance is CommonButtonSkin", instance is CommonButtonSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}
