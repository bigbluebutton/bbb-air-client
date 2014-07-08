package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class DisconnectUserSignalTest
	{		
		protected var instance:DisconnectUserSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new DisconnectUserSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDisconnectUserSignal():void
		{
			assertTrue("instance is DisconnectUserSignal", instance is DisconnectUserSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}