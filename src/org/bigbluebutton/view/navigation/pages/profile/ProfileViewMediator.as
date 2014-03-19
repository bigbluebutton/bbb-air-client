package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.command.ShareCameraSignal;
	import org.bigbluebutton.command.RaiseHandSignal;
	import org.bigbluebutton.command.ShareMicrophoneSignal;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ProfileViewMediator extends Mediator
	{
		[Inject]
		public var view: IProfileView;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var shareCameraSignal: ShareCameraSignal;
		
		[Inject]
		public var shareMicrophoneSignal: ShareMicrophoneSignal;
		
		[Inject] 
		public var raiseHandSignal: RaiseHandSignal;
		
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			userSession.userList.userChangeSignal.add(userChangeHandler);
			
			view.userNameText.text = userSession.userList.me.name;
			
			view.cameraOnOffText.text = ResourceManager.getInstance().getString('resources', userSession.userList.me.hasStream? 'profile.settings.camera.on':'profile.settings.camera.off');
			view.micOnOffText.text = ResourceManager.getInstance().getString('resources', userSession.userList.me.voiceJoined? 'profile.settings.mic.on':'profile.settings.mic.off');
			view.raiseHandText.text = ResourceManager.getInstance().getString('resources', userSession.userList.me.raiseHand ?'profile.settings.handLower' : 'profile.settings.handRaise');
			
			view.shareCameraButton.addEventListener(MouseEvent.CLICK, onShareCameraClick);
			view.shareMicButton.addEventListener(MouseEvent.CLICK, onShareMicClick);
			view.raiseHandButton.addEventListener(MouseEvent.CLICK, onRaiseHandClick);
		}
		
		private function userChangeHandler(user:User, type:int):void
		{
			if (user.me) {
				if (type == UserList.JOIN_AUDIO) {
					view.micOnOffText.text = ResourceManager.getInstance().getString('resources', userSession.userList.me.voiceJoined ? 'profile.settings.mic.on' : 'profile.settings.mic.off');
				} else if (type == UserList.HAS_STREAM) {
					view.cameraOnOffText.text = ResourceManager.getInstance().getString('resources', userSession.userList.me.hasStream ? 'profile.settings.camera.on' : 'profile.settings.camera.off');
				} else if (type == UserList.RAISE_HAND) { 
					view.raiseHandText.text = ResourceManager.getInstance().getString('resources', userSession.userList.me.raiseHand ?'profile.settings.handLower' : 'profile.settings.handRaise');
				}
			}
		}
			
		protected function onShareCameraClick(event:MouseEvent):void
		{
			shareCameraSignal.dispatch(!userSession.userList.me.hasStream);
		}
		
		protected function onShareMicClick(event:MouseEvent):void
		{
			shareMicrophoneSignal.dispatch(!userSession.userList.me.voiceJoined);
		}
		
		protected function onRaiseHandClick(event:MouseEvent):void
		{			
			raiseHandSignal.dispatch(!userSession.userList.me.raiseHand, userSession.userId);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			userSession.userList.userChangeSignal.remove(userChangeHandler);
			
			view.shareCameraButton.removeEventListener(MouseEvent.CLICK, onShareCameraClick);
			view.shareMicButton.removeEventListener(MouseEvent.CLICK, onShareMicClick);
			view.raiseHandButton.removeEventListener(MouseEvent.CLICK, onRaiseHandClick);
			
			view.dispose();
			view = null;
		}
	}
}
