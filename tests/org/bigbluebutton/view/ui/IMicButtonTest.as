package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.core.view.IView;
	import org.flexunit.asserts.assertTrue;
	
	public class IMicButtonTest
	{		
		protected var instance:IMicButton;
		
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
		public function instantiated_implementsIView():void
		{
			assertTrue("instance implements IView", instance is IView);
		}
	}
}
