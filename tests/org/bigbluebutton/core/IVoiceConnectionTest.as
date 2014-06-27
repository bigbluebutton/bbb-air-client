package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class IVoiceConnectionTest
	{		
		protected var instance:IVoiceConnection;
		
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
		public function instantiated_isInstanceOfIVoiceConnection():void 
		{
			assertTrue("instance is IVoiceConnection", instance is IVoiceConnection);
		}
	}
}
