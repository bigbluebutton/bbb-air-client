package org.mconf.mobile.command
{
	import org.mconf.mobile.core.IJoinService;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSettings;
	import org.mconf.mobile.view.ui.ILoginButton;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class JoinMeetingCommand extends Command
	{		
		[Inject]
		public var joinService: IJoinService;
				
		[Inject]
		public var url: String;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		override public function execute():void
		{
			joinService.successfullyJoinedMeetingSignal.add(successfullyJoined);
			joinService.unsuccessfullyJoinedMeetingSignal.add(unsuccessfullyJoined);
			
			joinService.load(url);
		}

		private function successfullyJoined(user:Object):void {
			Log.getLogger("org.mconf.mobile").info(String(this) + ":successfullyJoined()");
			conferenceParameters.load(user);
		}
		
		private function unsuccessfullyJoined(reason:String):void {
			Log.getLogger("org.mconf.mobile").info(String(this) + ":unsuccessfullyJoined()");
		}
		
	}
}