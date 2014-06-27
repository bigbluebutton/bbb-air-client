package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class BigBlueButtonConnectionTest
	{		
		protected var instance:BigBlueButtonConnection;
		
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
		public function instantiated_isInstanceOfBigBlueButtonConnection():void
		{
			assertTrue("instance is BigBlueButtonConnection", instance is BigBlueButtonConnection);
		}
		
		[Test]
		public function instantiated_implementsIBigBlueButtonConnectionInterface():void
		{
			assertTrue("instance implements IBigBlueButtonConnection interface", instance is IBigBlueButtonConnection);
		}
		
		[Test]
		public function instantiated_extendsDefaultConnectionCallback():void
		{
			assertTrue("instance extends DefaultConnectionCallback", instance is DefaultConnectionCallback);
		}
	}
}