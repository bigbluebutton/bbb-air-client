package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ShareMicrophoneCommandTest
	{		
		protected var instance:ShareMicrophoneCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new ShareMicrophoneCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfShareCameraCommand():void
		{
			assertTrue("instance is ShareMicrophoneCommand", instance is ShareMicrophoneCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}