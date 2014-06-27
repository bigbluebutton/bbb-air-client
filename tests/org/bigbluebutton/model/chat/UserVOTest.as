package org.bigbluebutton.model.chat
{
	import org.flexunit.asserts.assertTrue;
	
	public class UserVOTest
	{		
		protected var instance:UserVO;
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new UserVO("testUsername", "testID");
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUserVO():void
		{
			assertTrue("instance is UserVO", instance is UserVO);
		}
	}
}