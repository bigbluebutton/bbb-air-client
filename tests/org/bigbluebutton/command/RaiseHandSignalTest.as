package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class RaiseHandSignalTest
	{		
		protected var instance:RaiseHandSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new RaiseHandSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfRaiseHandSignal():void
		{
			assertTrue("instance is RaiseHandSignal", instance is RaiseHandSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}