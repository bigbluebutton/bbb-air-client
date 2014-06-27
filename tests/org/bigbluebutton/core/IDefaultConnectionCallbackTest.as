package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IDefaultConnectionCallbackTest
	{		
		protected var instance:IDefaultConnectionCallback;
		
		[Before]
		public function setUp():void
		{
			instance = new DefaultConnectionCallback();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIDefaultConnectionCallback():void 
		{
			assertTrue("instance is IDefaultConnectionCallback", instance is IDefaultConnectionCallback);
		}
	}
}