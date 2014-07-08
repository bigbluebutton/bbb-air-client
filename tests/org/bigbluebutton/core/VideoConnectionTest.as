package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class VideoConnectionTest
	{		
		protected var instance:VideoConnection;
		
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
		public function instantiated_isInstanceOfVideoConnection():void 
		{
			assertTrue("instance is VideoConnection", instance is VideoConnection);
		}
		
		[Test]
		public function instantiated_extendsDefaultConnectionCallback():void
		{
			assertTrue("instance extends DefaultConnectionCallback", instance is DefaultConnectionCallback);
		}
		
		[Test]
		public function instantiated_implementsIVideoConnectionInterface():void
		{
			assertTrue("instance implements IVideoConnection interface", instance is IVideoConnection);
		}
	}
}