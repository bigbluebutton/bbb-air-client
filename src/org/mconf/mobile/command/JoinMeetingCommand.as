package org.mconf.mobile.command
{
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.ILoginService;
	import org.mconf.mobile.model.ConferenceParameters;
	import org.mconf.mobile.model.Config;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.model.IUserSettings;
	import org.mconf.mobile.model.IUserUISession;
	import org.mconf.mobile.view.ui.ILoginButton;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class JoinMeetingCommand extends Command
	{		
		[Inject]
		public var loginService: ILoginService;
				
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var url: String;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var connectSignal: ConnectSignal;
		
		override public function execute():void
		{
			loginService.successJoinedSignal.add(successJoined);
			loginService.successGetConfigSignal.add(successConfig);
			loginService.unsuccessJoinedSignal.add(unsuccessJoined);
			
			userUISession.loading = true;

			loginService.load(url);
		}

		protected function successJoined(userObject:Object):void {
			Log.getLogger("org.mconf.mobile").info(String(this) + ":successJoined()");
			
			conferenceParameters.load(userObject);
			
			connectSignal.dispatch(new String(userSession.config.application.uri));
		}
		
		protected function successConfig(config:Config):void {
			userSession.config = config;
		}
		
		protected function unsuccessJoined(reason:String):void {
			Log.getLogger("org.mconf.mobile").info(String(this) + ":unsuccessJoined()");
			
			userUISession.loading = false;
		}
		
	}
}