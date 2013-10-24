package org.mconf.mobile.command
{
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.view.navigation.IPagesNavigatorView;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class RemovePageCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var pageNavigatorView: IPagesNavigatorView;
		
		[Inject]
		public var pageName: String;
		
		override public function execute():void
		{
			userSession.popPage();
			pageNavigatorView.popView();
			
			trace("MicrophoneEnableCommand.execute() - userSession.currentPage = "+userSession.currentPage);
		}
	}
}