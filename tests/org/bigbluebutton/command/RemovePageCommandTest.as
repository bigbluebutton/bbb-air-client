package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class RemovePageCommandTest
	{		
		protected var instance:RemovePageCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new RemovePageCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfRemovePageCommand():void
		{
			assertTrue("instance is RemovePageCommand", instance is RemovePageCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}