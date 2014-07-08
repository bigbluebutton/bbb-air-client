package org.bigbluebutton.view.skins
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class RadioButtonSkinTest
	{		
		protected var instance:RadioButtonSkin;
		
		[Before]
		public function setUp():void
		{
			instance = new RadioButtonSkin();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfRadioButtonSkin():void
		{
			assertTrue("instance is RadioButtonSkin", instance is RadioButtonSkin);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}