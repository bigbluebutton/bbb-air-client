package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class ShareMicrophoneSignalTest
	{		
		protected var instance:ShareMicrophoneSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new ShareMicrophoneSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfShareMicrophoneSignal():void
		{
			assertTrue("instance is ShareMicrophoneSignall", instance is ShareMicrophoneSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}