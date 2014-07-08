package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class DefaultConnectionCallbackTest
	{		
		protected var instance:DefaultConnectionCallback;
		
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
		public function instantiated_isInstanceOfDefaultConnectionCallback():void
		{
			assertTrue("instance is DefaultConnectionCallback", instance is DefaultConnectionCallback);
		}
		
		[Test]
		public function instantiated_implementsIDefaultConnectionCallbackInterface():void
		{
			assertTrue("instance implements IDefaultConnectionCallback interface", instance is IDefaultConnectionCallback);
		}
	}
}