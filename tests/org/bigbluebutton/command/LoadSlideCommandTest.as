package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class LoadSlideCommandTest
	{		
		protected var instance:LoadSlideCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new LoadSlideCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfLoadSlideCommand():void
		{
			assertTrue("instance is LoadSlideCommand", instance is LoadSlideCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}