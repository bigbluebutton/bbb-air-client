package org.bigbluebutton.model
{
	import org.flexunit.asserts.assertTrue;

	public class IUserUISessionTest
	{		
		protected var instance:IUserUISession;
		
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
		public function instantiated_isInstanceOfIUserUISession():void
		{
			assertTrue("instance is IUserUISession", instance is IUserUISession);
		}
	}
}