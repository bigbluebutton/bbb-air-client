package org.bigbluebutton.model.presentation
{
	import org.flexunit.asserts.assertTrue;
	
	public class PresentationListTest
	{		
		protected var instance:PresentationList;
		
		[Before]
		public function setUp():void
		{
			instance = new PresentationList();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPresentationList():void
		{
			assertTrue("instance is PresentationList", instance is PresentationList);
		}
	}
}