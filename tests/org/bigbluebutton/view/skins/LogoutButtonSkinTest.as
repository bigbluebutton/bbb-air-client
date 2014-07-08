package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class LogoutButtonSkinTest
	{		
		protected var instance:LogoutButtonSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new LogoutButtonSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfLogoutButtonSkin():void
		{
			assertTrue("instance is LogoutButtonSkin", instance is LogoutButtonSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}
