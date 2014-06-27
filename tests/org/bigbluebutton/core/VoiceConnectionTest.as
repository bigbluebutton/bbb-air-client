package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class VoiceConnectionTest
	{		
		protected var instance:VoiceConnection;
		
		[Before]
		public function setUp():void
		{
			instance = new VoiceConnection();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfVoiceConnection():void 
		{
			assertTrue("instance is VoiceConnection", instance is VoiceConnection);
		}
		
		[Test]
		public function instantiated_extendsDefaultConnectionCallback():void
		{
			assertTrue("instance extends DefaultConnectionCallback", instance is DefaultConnectionCallback);
		}
		
		[Test]
		public function instantiated_implementsIVoiceConnectionInterface():void
		{
			assertTrue("instance implements IVoiceConnection interface", instance is IVoiceConnection);
		}
	}
}