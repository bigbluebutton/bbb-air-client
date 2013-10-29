package org.mconf.mobile.view.ui
{
	import org.mconf.mobile.command.JoinMeetingSignal;
	import org.mconf.mobile.command.MicrophoneEnableSignal;
	import org.mconf.mobile.core.IJoinService;
	import org.mconf.mobile.core.JoinService;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSettings;
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
			Log.getLogger("org.mconf.mobile").info(String(this));
			
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
			Log.getLogger("org.mconf.mobile").info(String(this) + ":joinMeeting()");
			joinMeetingSignal.dispatch(joinUrl);
		}
	}
}