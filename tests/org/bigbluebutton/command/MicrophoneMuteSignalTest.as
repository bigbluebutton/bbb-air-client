package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class MicrophoneMuteSignalTest
	{		
		protected var instance:MicrophoneMuteSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new MicrophoneMuteSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfMicrophoneMuteSignal():void
		{
			assertTrue("instance is MicrophoneMuteSignal", instance is MicrophoneMuteSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}