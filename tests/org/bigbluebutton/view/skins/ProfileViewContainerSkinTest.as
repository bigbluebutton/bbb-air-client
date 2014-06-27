package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class ProfileViewContainerSkinTest
	{		
		protected var instance:ProfileViewContainerSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new ProfileViewContainerSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfProfileViewContainerSkin():void
		{
			assertTrue("instance is ProfileViewContainerSkin", instance is ProfileViewContainerSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}