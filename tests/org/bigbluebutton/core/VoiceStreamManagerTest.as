package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class VoiceStreamManagerTest
	{		
		protected var instance:VoiceStreamManager;
		
		[Before]
		public function setUp():void
		{
			instance = new VoiceStreamManager();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfVoiceStreamManager():void 
		{
			assertTrue("instance is VoiceStreamManager", instance is VoiceStreamManager);
		}
	}
}