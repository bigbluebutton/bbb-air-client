package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class LoginServiceTest
	{		
		protected var instance:LoginService;
		
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
		public function instantiated_isInstanceOfLoginService():void
		{
			assertTrue("instance is LoginService", instance is LoginService);
		}
		
		[Test]
		public function instantiated_implementsILoginService():void
		{
			assertTrue("instance implements ILoginService", instance is ILoginService);
		}
	}
}