package org.bigbluebutton.command {
	
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.view.navigation.IPagesNavigatorView;
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class RemovePageCommand extends Command {
		
		[Inject]
		public var userSession:IUserUISession;
		
		[Inject]
		public var pageNavigatorView:IPagesNavigatorView;
		
		[Inject]
		public var pageName:String;
		
		override public function execute():void {
			userSession.popPage();
			pageNavigatorView.popView();
			trace("MicrophoneEnableCommand.execute() - userSession.currentPage = " + userSession.currentPage);
		}
	}
}
