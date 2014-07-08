package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class RaiseHandCommandTest
	{		
		protected var instance:RaiseHandCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new RaiseHandCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfRaiseHandCommand():void
		{
			assertTrue("instance is RaiseHandCommand", instance is RaiseHandCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}