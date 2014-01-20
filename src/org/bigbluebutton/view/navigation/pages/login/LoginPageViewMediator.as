package org.bigbluebutton.view.navigation.pages.login
{
	import org.bigbluebutton.command.JoinMeetingSignal;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.view.navigation.IPagesNavigatorView;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class LoginPageViewMediator extends Mediator
	{
		[Inject]
		public var view: ILoginPageView;
		
		[Inject]
		public var joinMeetingSignal: JoinMeetingSignal;
		
		[Inject]
		public var userSession: IUserSession;
		
		//[Inject]
		//public var pageNavigatorView: IPagesNavigatorView;
		
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			var endURL:String = "http://test-install.blindsidenetworks.com/bigbluebutton/api/join?meetingID=Demo%20Meeting&fullName=Air%20client&password=ap&checksum=e9c5f7a397509e908ada2787aa0a284842ef4faf";
						
			joinMeetingSignal.dispatch(endURL);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			view = null;
		}
	}
}