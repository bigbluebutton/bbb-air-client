package org.bigbluebutton.view.ui
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Button;
	
	public class SwapCameraButtonTest
	{		
		protected var instance:SwapCameraButton;
		
		[Before]
		public function setUp():void
		{
			instance = new SwapCameraButton();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfSwapCameraButton():void
		{
			assertTrue("instance is SwapCameraButton", instance is SwapCameraButton);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Button component", instance is Button);
		}
		
		[Test]
		public function instantiated_implementsISwapCameraButton():void
		{
			assertTrue("instance implements ISwapCameraButton", instance is ISwapCameraButton);
		}
		
		[Test]
		public function instantiated_visibleByDefault():void
		{
			assertTrue("SwapCamera button is visible by default", instance.visible);
		}
	}
}
