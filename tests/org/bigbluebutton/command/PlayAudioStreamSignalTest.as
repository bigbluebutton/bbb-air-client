package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class PlayAudioStreamSignalTest
	{		
		protected var instance:PlayAudioStreamSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new PlayAudioStreamSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPlayAudioStreamSignal():void
		{
			assertTrue("instance is PlayAudioStreamSignal", instance is PlayAudioStreamSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}