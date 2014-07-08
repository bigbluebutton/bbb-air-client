package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class ILoginServiceTest
	{		
		protected var instance:ILoginService;
		
		[Before]
		public function setUp():void
		{
			instance = new LoginService();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfILoginService():void 
		{
			assertTrue("instance is ILoginService", instance is ILoginService);
		}
	}
}