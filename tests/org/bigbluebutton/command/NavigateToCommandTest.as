package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class NavigateToCommandTest
	{		
		protected var instance:NavigateToCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new NavigateToCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfNavigateToCommand():void
		{
			assertTrue("instance is NavigateToCommand", instance is NavigateToCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}