package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class BBBLogoSkinTest
	{		
		protected var instance:BBBLogoSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new BBBLogoSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfBBBLogoSkin():void
		{
			assertTrue("instance is BBBLogoSkin", instance is BBBLogoSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}