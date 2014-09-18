package org.bigbluebutton.view.ui
{
	import flash.events.MouseEvent;
	
	import org.bigbluebutton.command.MicrophoneMuteSignal;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MicButtonMediator extends Mediator
	{
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var microphoneMuteSignal: MicrophoneMuteSignal;
				
		[Inject]
		public var view: IMicButton;
		
		/**
		 * Initialize listeners and Mediator initial state
		 */
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			(view as MicButton).addEventListener(MouseEvent.CLICK, mouseEventClickHandler);
			
			userSession.userList.userChangeSignal.add(userChangeHandler);
			
			userSession.userList.applyPresenterModeratorLockSettingsSignal.add(applyPresenterModeratorLockSettings);
			userSession.userList.applyViewerLockSettingsSignal.add(applyViewerLockSettings);
			
			view.setVisibility(userSession.userList.me.voiceJoined);  
			view.muted = userSession.userList.me.muted;
		}
		
		/**
		 * Handle events to turnOn microphone
		 */
		private function mouseEventClickHandler(e:MouseEvent):void
		{
			microphoneMuteSignal.dispatch(userSession.userList.me);
		}
		
		/**
		 * Update the view when there is a chenge in the model
		 */ 
		private function userChangeHandler(user:User, type:int):void
		{
			if (user.me) {
				if (type == UserList.JOIN_AUDIO) {
					view.setVisibility(user.voiceJoined);
				} else if (type == UserList.MUTE) {
					view.muted = user.muted;
					
					// Special care needs to be taken with the mute button when lock settings are in place.
					// For example, if the moderator unmutes somebody, they should still be able to mute
					// themselves again when they are done talking:
					
					if(user.disableMyMic) {
						if(!user.muted) { // Moderator unmuted me, or I'm moderator/presenter, so don't disable me!
							view.enabled = true;
						} else if(user.role != User.MODERATOR && !user.presenter) { // I have been muted, and lock settings are in place!
							view.enabled = false;
						}
					}
				}
			}
		}
		
		private function applyPresenterModeratorLockSettings():void
		{
			view.enabled = true;
		}
		
		private function applyViewerLockSettings():void
		{
			view.enabled = userSession.userList.me.disableMyMic ? false : true;
		}
		
		/**
		 * Destroy view and listeners
		 */
		override public function destroy():void
		{
			(view as MicButton).removeEventListener(MouseEvent.CLICK, mouseEventClickHandler);
			userSession.userList.userChangeSignal.remove(userChangeHandler);
			
			userSession.userList.applyPresenterModeratorLockSettingsSignal.remove(applyPresenterModeratorLockSettings);
			userSession.userList.applyViewerLockSettingsSignal.remove(applyViewerLockSettings);
			
			super.destroy();
			
			view.dispose();
			
			view = null;
		}
		
	}
}