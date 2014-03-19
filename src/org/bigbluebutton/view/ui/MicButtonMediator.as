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
			
			view.setVisibility(userSession.userList.me.voiceJoined);  
			view.selected = userSession.userList.me.muted;
		}
		
		/**
		 * Destroy view and listeners
		 */
		override public function destroy():void
		{
			(view as MicButton).removeEventListener(MouseEvent.CLICK, mouseEventClickHandler);
			userSession.userList.userChangeSignal.remove(userChangeHandler);
			
			super.destroy();
			
			view.dispose();
			
			view = null;
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
					view.selected = user.muted;
				}
			}
		}
	}
}