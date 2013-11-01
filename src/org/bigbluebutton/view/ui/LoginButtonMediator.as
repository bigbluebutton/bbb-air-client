package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.command.JoinMeetingSignal;
	import org.bigbluebutton.command.MicrophoneEnableSignal;
	import org.bigbluebutton.core.ILoginService;
	import org.bigbluebutton.core.LoginService;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSettings;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class LoginButtonMediator extends Mediator
	{
		[Inject]
		public var joinMeetingSignal: JoinMeetingSignal;
		
		[Inject]
		public var view: ILoginButton;

		/**
		 * Initialize listeners and Mediator initial state
		 */
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			view.loginSignal.add(joinMeeting);
		}
		
		/**
		 * Destroy view and listeners
		 */
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			
			view = null;
		}
		
		private function joinMeeting(joinUrl:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":joinMeeting()");
			joinMeetingSignal.dispatch(joinUrl);
		}
	}
}