package org.bigbluebutton.model
{
	import org.flexunit.asserts.assertTrue;
	
	public class UserUISessionTest
	{		
		protected var instance:UserUISession;
		
		[Before]
		public function setUp():void
		{
			instance = new UserUISession();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUserUISession():void
		{
			assertTrue("instance is UserSession", instance is UserUISession);
		}
		
		[Test]
		public function instantiated_implementsIUserUISession():void
		{
			assertTrue("instance implements IUserUISession interface", instance is IUserUISession);
		}
	}
}