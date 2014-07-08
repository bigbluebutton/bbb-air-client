package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IVideoConnectionTest
	{		
		protected var instance:IVideoConnection;
		
		[Before]
		public function setUp():void
		{
			instance = new VideoConnection();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfIVideoConnection():void 
		{
			assertTrue("instance is IVideoConnection", instance is IVideoConnection);
		}
	}
}