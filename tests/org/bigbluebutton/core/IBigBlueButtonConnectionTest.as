package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IBigBlueButtonConnectionTest
	{		
		protected var instance:IBigBlueButtonConnection;
		
		[Before]
		public function setUp():void
		{
			instance = new BigBlueButtonConnection();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIBigBlueButtonConnection():void 
		{
			assertTrue("instance is IBigBlueButtonConnection", instance is IBigBlueButtonConnection);
		}
	}
}
