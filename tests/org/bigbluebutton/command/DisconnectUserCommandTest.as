package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class DisconnectUserCommandTest
	{		
		protected var instance:DisconnectUserCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new DisconnectUserCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDisconnectUserCommand():void
		{
			assertTrue("instance is DisconnectUserCommand", instance is DisconnectUserCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}