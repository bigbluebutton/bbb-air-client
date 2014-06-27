package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class LoadSlideSignalTest
	{		
		protected var instance:LoadSlideSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new LoadSlideSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfLoadSlideSignal():void
		{
			assertTrue("instance is LoadSlideSignal", instance is LoadSlideSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}