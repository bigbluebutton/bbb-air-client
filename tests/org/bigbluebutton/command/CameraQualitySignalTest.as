package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class CameraQualitySignalTest
	{		
		protected var instance:CameraQualitySignal;
		
		[Before]
		public function setUp():void
		{
			instance = new CameraQualitySignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfCameraQualitySignal():void
		{
			assertTrue("instance is CameraQualitySignal", instance is CameraQualitySignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}