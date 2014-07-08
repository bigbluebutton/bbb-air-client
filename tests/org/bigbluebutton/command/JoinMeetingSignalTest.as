package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class JoinMeetingSignalTest
	{		
		protected var instance:JoinMeetingSignal;
		
		[Before]
		public function setUp():void
		{
			instance = new JoinMeetingSignal();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfJoinMeetingSignal():void
		{
			assertTrue("instance is JoinMeetingSignal", instance is JoinMeetingSignal);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}