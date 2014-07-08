package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class JoinServiceTest
	{		
		protected var instance:JoinService;
		
		[Before]
		public function setUp():void
		{
			instance = new JoinService();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfJoinService():void
		{
			assertTrue("instance is JoinService", instance is JoinService);
		}
	}
}