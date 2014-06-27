package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class ShareCameraCommandTest
	{		
		protected var instance:ShareCameraCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new ShareCameraCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfShareCameraCommand():void
		{
			assertTrue("instance is ShareCameraCommand", instance is ShareCameraCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}