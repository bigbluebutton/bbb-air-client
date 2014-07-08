package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class ConnectSignalTest
	{		
		protected var instance:ConnectSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new ConnectSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfConnectSignal():void
		{
			assertTrue("instance is ConnectSignal", instance is ConnectSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}