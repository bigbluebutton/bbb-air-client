package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class NavigateToSignalTest
	{		
		protected var instance:NavigateToSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new NavigateToSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfNavigateToSignal():void
		{
			assertTrue("instance is NavigateToSignal", instance is NavigateToSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}