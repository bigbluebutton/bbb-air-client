package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class PresentationServiceTest
	{		
		protected var instance:PresentationService;
		
		[Before]
		public function setUp():void
		{
			instance = new PresentationService();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPresentationService():void
		{
			assertTrue("instance is PresentationService", instance is PresentationService);
		}
		
		[Test]
		public function instantiated_implementsIPresentationService():void
		{
			assertTrue("instance implements IPresentationService", instance is IPresentationService);
		}
	}
}
