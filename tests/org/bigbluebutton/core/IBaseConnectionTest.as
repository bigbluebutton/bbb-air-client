package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IBaseConnectionTest
	{		
		protected var instance:IBaseConnection;
		
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
		public function instantiated_isInstanceOfIBaseConnection():void 
		{
			assertTrue("instance is IBaseConnection", instance is IBaseConnection);
		}
	}
}