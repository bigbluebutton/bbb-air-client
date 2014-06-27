package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class EnterServiceTest
	{		
		protected var instance:EnterService;
		
		[Before]
		public function setUp():void
		{
			instance = new EnterService();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfEnterService():void 
		{
			assertTrue("instance is EnterService", instance is EnterService);
		}
	}
}
