package org.bigbluebutton.command
{
	import org.bigbluebutton.core.IUsersService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class RaiseHandCommand extends Command
	{
		[Inject]
		public var userService: IUsersService;
		
		[Inject]
		public var userIds: String;
		
		[Inject]
		public var raised: Boolean;
		
		override public function execute():void
		{
		    trace("RaiseHandCommand.execute() - handRaised = " + raised);
			userService.raiseHand(userIds, raised);
		}
	}
}