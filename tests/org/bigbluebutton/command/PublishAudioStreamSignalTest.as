package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class PublishAudioStreamSignalTest
	{		
		protected var instance:PublishAudioStreamSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new PublishAudioStreamSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPublishAudioStreamSignal():void
		{
			assertTrue("instance is PublishAudioStreamSignal", instance is PublishAudioStreamSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}