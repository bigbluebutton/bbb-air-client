package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class ShareCameraSignalTest
	{		
		protected var instance:ShareCameraSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new ShareCameraSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfShareCameraSignal():void
		{
			assertTrue("instance is ShareCameraSignal", instance is ShareCameraSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}