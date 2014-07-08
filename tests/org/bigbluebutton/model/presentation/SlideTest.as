package org.bigbluebutton.model.presentation
{
	import org.flexunit.asserts.assertTrue;

	public class SlideTest
	{		
		protected var instance:Slide;
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new Slide(1, "testSlideURI", "testThumbURI", "testTxtURI", true);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfSlide():void
		{
			assertTrue("instance is Slide", instance is Slide);
		}
	}
}