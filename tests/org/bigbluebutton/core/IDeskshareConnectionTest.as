package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IDeskshareConnectionTest
	{		
		protected var instance:IDeskshareConnection;
		
		[Before]
		public function setUp():void
		{
			instance = new DeskshareConnection();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIDeskshareConnection():void 
		{
			assertTrue("instance is IDeskshareConnection", instance is IDeskshareConnection);
		}
	}
}