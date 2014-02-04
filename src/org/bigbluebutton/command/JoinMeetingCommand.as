package org.bigbluebutton.command
{
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.ILoginService;
	import org.bigbluebutton.model.ConferenceParameters;
	import org.bigbluebutton.model.Config;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserSettings;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.view.ui.ILoginButton;
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
			Log.getLogger("org.bigbluebutton").info(String(this) + ":successJoined()");
			
			conferenceParameters.load(userObject);
			
			connectSignal.dispatch(new String(userSession.config.application.uri));
		}
		
		protected function successConfig(config:Config):void {
			userSession.config = config;
		}
		
		protected function unsuccessJoined(reason:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":unsuccessJoined()");
			
			userUISession.loading = false;
			userUISession.unsuccessJoined.dispatch(reason);
		}
		
	}
}