package org.bigbluebutton.view.navigation.pages
{
	import org.flexunit.asserts.assertTrue;
	
	public class TransitionAnimationENUMTest
	{		
		protected var instance:TransitionAnimationENUM;
		
		[Before]
		public function setUp():void
		{
			instance = new TransitionAnimationENUM();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfTransitionAnimationENUM():void
		{
			assertTrue("instance is TransitionAnimationENUM", instance is TransitionAnimationENUM);
		}		
	}
}