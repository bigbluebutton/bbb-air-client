package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class MicrophoneMuteCommandTest
	{		
		protected var instance:MicrophoneMuteCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new MicrophoneMuteCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfMicrophoneMuteCommand():void
		{
			assertTrue("instance is MicrophoneMuteCommand", instance is MicrophoneMuteCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}