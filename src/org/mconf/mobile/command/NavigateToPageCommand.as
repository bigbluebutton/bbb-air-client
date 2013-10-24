package org.mconf.mobile.command
{
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.view.navigation.pages.ActionsENUM;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class NavigateToPageCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var pageName: String;
		
		[Inject]
		public var actionName: Object;
		
		override public function execute():void
		{
			// update model
			if(pageName != null && pageName != "")
			{
				userSession.pushPage(pageName);
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