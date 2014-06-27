package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class ProfileSettingsButtonSkinTest
	{		
		protected var instance:ProfileSettingsButtonSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new ProfileSettingsButtonSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfProfileSettingsButtonSkin():void
		{
			assertTrue("instance is ProfileSettingsButtonSkin", instance is ProfileSettingsButtonSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}