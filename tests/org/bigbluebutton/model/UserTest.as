package org.bigbluebutton.model
{
	import org.flexunit.asserts.assertTrue;
	
	public class UserTest
	{		
		protected var instance:User;
		
		[Before]
		public function setUp():void
		{
			instance = new User();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUser():void
		{
			assertTrue("instance is User", instance is User);
		}
	}
}