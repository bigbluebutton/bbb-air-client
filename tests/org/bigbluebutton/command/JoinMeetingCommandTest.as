package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class JoinMeetingCommandTest
	{		
		protected var instance:JoinMeetingCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new JoinMeetingCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfJoinMeetingCommand():void
		{
			assertTrue("instance is JoinMeetingCommand", instance is JoinMeetingCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}