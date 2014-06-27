package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IPresentationServiceTest
	{		
		protected var instance:IPresentationService;
		
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
		public function instantiated_isInstanceOfIPresentationService():void 
		{
			assertTrue("instance is IPresentationService", instance is IPresentationService);
		}
	}
}
