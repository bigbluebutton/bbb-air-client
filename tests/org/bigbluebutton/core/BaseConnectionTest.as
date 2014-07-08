package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class BaseConnectionTest
	{		
		protected var instance:BaseConnection;
		
		[Before]
		public function setUp():void
		{
			instance = new BaseConnection();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfBaseConnection():void
		{
			assertTrue("instance is BaseConnection", instance is BaseConnection);
		}
		
		[Test]
		public function instantiated_implementsIBaseConnectionInterface():void
		{
			assertTrue("instance implements IBaseConnection interface", instance is IBaseConnection);
		}
	}
}
