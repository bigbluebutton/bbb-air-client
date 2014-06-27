package org.bigbluebutton.view.ui
{
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Button;
	
	public class MicButtonTest
	{		
		protected var instance:MicButton;
		
		[Before]
		public function setUp():void
		{
			instance = new MicButton();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfMicButton():void
		{
			assertTrue("instance is MicButton", instance is MicButton);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Button component", instance is Button);
		}
		
		[Test]
		public function instantiated_implementsIMicButton():void
		{
			assertTrue("instance implements IMicButton", instance is IMicButton);
		}
		
		[Test]
		public function instantiated_visibleByDefault():void
		{
			assertTrue("Mic button is visible by default", instance.visible);
		}
	}
}