package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class DeskshareConnectionTest
	{		
		protected var instance:DeskshareConnection;
		
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
		public function instantiated_isInstanceOfDeskshareConnection():void 
		{
			assertTrue("instance is DeskshareConnection", instance is DeskshareConnection);
		}
		
		[Test]
		public function instantiated_extendsDefaultConnectionCallback():void
		{
			assertTrue("instance extends DefaultConnectionCallback", instance is DefaultConnectionCallback);
		}
		
		[Test]
		public function instantiated_implementsIDeskshareConnectionInterface():void
		{
			assertTrue("instance implements IDeskshareConnection interface", instance is IDeskshareConnection);
		}
	}
}