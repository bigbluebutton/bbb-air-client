package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class UsersServiceTest
	{		
		protected var instance:UsersService;
		
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
		public function instantiated_isInstanceOfUsersService():void
		{
			assertTrue("instance is UsersService", instance is UsersService);
		}
		
		[Test]
		public function instantiated_implementsIUsersService():void
		{
			assertTrue("instance implements IUsersService", instance is IUsersService);
		}
	}
}