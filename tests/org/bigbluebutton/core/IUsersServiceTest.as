package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IUsersServiceTest
	{		
		protected var instance:IUsersService;
		
		[Before]
		public function setUp():void
		{
			instance = new UsersService();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIUsersService():void 
		{
			assertTrue("instance is IUsersService", instance is IUsersService);
		}
	}
}