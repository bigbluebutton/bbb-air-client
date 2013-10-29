package org.mconf.mobile.command
{
	import org.mconf.mobile.model.IUserUISession;
	import org.mconf.mobile.view.navigation.pages.ActionsENUM;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class NavigateToCommand extends Command
	{		
		[Inject]
		public var userSession: IUserUISession;
		
		[Inject]
		public var to: String;
		
		[Inject]
		public var actionName: Object;
		
		override public function execute():void
		{
			// update model
			if(to != null && to != "")
			{
				userSession.pushPage(to);
			}
			
			if(actionName != null && actionName != "")
			{
				switch(actionName)
				{
					case ActionsENUM.CLOSE:
					{
						userSession.popPage();
						break;
					}
				}				
			}
			
			trace("MicrophoneEnableCommand.execute() - userSession.currentPage = "+userSession.currentPage);
		}
	}
}