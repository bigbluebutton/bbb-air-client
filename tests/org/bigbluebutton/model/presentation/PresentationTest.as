package org.bigbluebutton.model.presentation
{
	import org.flexunit.asserts.assertTrue;

	public class PresentationTest
	{		
		protected var instance:Presentation;
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new Presentation("testFileName", new Function(), 1, true);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPresentation():void
		{
			assertTrue("instance is Presentation", instance is Presentation);
		}
	}
}