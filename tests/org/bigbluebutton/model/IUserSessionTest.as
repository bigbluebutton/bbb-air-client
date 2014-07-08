package org.bigbluebutton.model
{
	import org.flexunit.asserts.assertTrue;

	public class IUserSessionTest
	{		
		protected var instance:IUserSession;
		
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
		public function instantiated_isInstanceOfIUserSession():void
		{
			assertTrue("instance is IUserSession", instance is IUserSession);
		}
	}
}