package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.core.view.IView;
	import org.flexunit.asserts.assertTrue;
	
	public class ISwapCameraButtonTest
	{		
		protected var instance:ISwapCameraButton;
		
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
		public function instantiated_implementsIView():void
		{
			assertTrue("instance implements IView", instance is IView);
		}
	}
}
