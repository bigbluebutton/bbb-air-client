package org.bigbluebutton.command
{
	import org.bigbluebutton.model.IUserUISession;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class NavigateToCommand extends Command
	{		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var to: String;
		
		[Inject]
		public var details: Object;
		
		override public function execute():void
		{
			if(to != null && to != "")
			{
				userUISession.pushPage(to, details);
			}
			else
			{
				userUISession.popPage();
			}
			
			trace("NavigateToCommand.execute() - userUISession.currentPage = "+userUISession.currentPage);
		}
	}
}