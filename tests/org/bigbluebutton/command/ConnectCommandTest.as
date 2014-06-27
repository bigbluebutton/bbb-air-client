package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class ConnectCommandTest
	{		
		protected var instance:ConnectCommand;
		
		[Before]
		public function setUp():void
		{
			instance = new ConnectCommand();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}	
		
		[Test]
		public function instantiated_isInstanceOfConnectCommand():void
		{
			assertTrue("instance is ConnectCommand", instance is ConnectCommand);
		}
		
		[Test]
		public function instantiated_implementsRobotlegsCommand():void
		{
			assertTrue("instance is robotlegs Command", instance is Command);
		}
	}
}