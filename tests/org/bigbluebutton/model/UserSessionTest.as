package org.bigbluebutton.model
{
	import org.flexunit.asserts.assertTrue;

	public class UserSessionTest
	{		
		protected var instance:UserSession;
		
		[Before]
		public function setUp():void
		{
			instance = new UserSession();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUserSession():void
		{
			assertTrue("instance is UserSession", instance is UserSession);
		}
		
		[Test]
		public function instantiated_implementsIUserSession():void
		{
			assertTrue("instance implements IUserSession interface", instance is IUserSession);
		}
	}
}