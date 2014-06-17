package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.events.MouseEvent;
	import flash.media.Camera;
	import flash.media.CameraPosition;
	
	import mx.events.ItemClickEvent;
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.command.CameraQualitySignal;
	import org.bigbluebutton.command.DisconnectUserSignal;
	import org.bigbluebutton.command.RaiseHandSignal;
	import org.bigbluebutton.command.ShareCameraSignal;
	import org.bigbluebutton.command.ShareMicrophoneSignal;
	import org.bigbluebutton.core.VideoConnection;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.view.navigation.pages.disconnect.enum.DisconnectEnum;
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
		
		[Inject]
		public var changeQualitySignal : CameraQualitySignal;
		
		[Inject]
		public var disconnectUserSignal: DisconnectUserSignal;
			
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			userSession.userList.userChangeSignal.add(userChangeHandler);
			
			var userMe:User = userSession.userList.me;		
			
			view.userNameText.text = userMe.name;		

			if (Camera.getCamera() == null)
			{
				view.shareCameraButton.label = ResourceManager.getInstance().getString('resources', 'profile.settings.camera.unavailable');
				view.shareCameraButton.enabled = false;
			}
			else
			{
				view.shareCameraButton.label = ResourceManager.getInstance().getString('resources', userMe.hasStream? 'profile.settings.camera.on':'profile.settings.camera.off');
				view.shareCameraButton.enabled = true;
			}
			
			view.shareCameraButton.addEventListener(MouseEvent.CLICK, onShareCameraClick);
			view.shareMicButton.addEventListener(MouseEvent.CLICK, onShareMicClick);
			view.raiseHandButton.addEventListener(MouseEvent.CLICK, onRaiseHandClick);
			view.cameraQualityRadioGroup.addEventListener(ItemClickEvent.ITEM_CLICK, onCameraQualityRadioGroupClick);
			view.setCameraQualityGroupVisibility(userSession.userList.me.hasStream);
			view.setCameraQuality(userSession.videoConnection.selectedCameraQuality);
			view.logoutButton.addEventListener(MouseEvent.CLICK, logoutClick);
		}
		
		private function userChangeHandler(user:User, type:int):void
		{
			if (user.me) {
				if (type == UserList.JOIN_AUDIO) {
					view.shareMicButton.label = ResourceManager.getInstance().getString('resources', user.voiceJoined ? 'profile.settings.mic.on' : 'profile.settings.mic.off');
				} else if (type == UserList.HAS_STREAM) {
					view.shareCameraButton.label = ResourceManager.getInstance().getString('resources', user.hasStream ? 'profile.settings.camera.on' : 'profile.settings.camera.off');
					view.setCameraQualityGroupVisibility(user.hasStream);
				} else if (type == UserList.RAISE_HAND) { 
					view.raiseHandButton.label = ResourceManager.getInstance().getString('resources', user.raiseHand ?'profile.settings.handLower' : 'profile.settings.handRaise');
				}
			}
		}
		
		protected function onShareCameraClick(event:MouseEvent):void
		{
			view.setCameraQuality(VideoConnection.CAMERA_QUALITY_MEDIUM);
			userSession.videoConnection.selectedCameraQuality = VideoConnection.CAMERA_QUALITY_MEDIUM;	
			shareCameraSignal.dispatch(!userSession.userList.me.hasStream, CameraPosition.FRONT);
		}
		
		protected function onShareMicClick(event:MouseEvent):void
		{
			shareMicrophoneSignal.dispatch(!userSession.userList.me.voiceJoined);
		}
		
		protected function onRaiseHandClick(event:MouseEvent):void
		{			
			raiseHandSignal.dispatch(userSession.userId, !userSession.userList.me.raiseHand);
		}
		
		protected function onCameraQualityRadioGroupClick(event:ItemClickEvent):void
		{
			switch(event.index)
			{
				case 0:
					changeQualitySignal.dispatch(VideoConnection.CAMERA_QUALITY_LOW);	
					break;
				case 1:
					changeQualitySignal.dispatch(VideoConnection.CAMERA_QUALITY_MEDIUM);
					break;
				case 2:
					changeQualitySignal.dispatch(VideoConnection.CAMERA_QUALITY_HIGH);	
					break;
				default:
					changeQualitySignal.dispatch(VideoConnection.CAMERA_QUALITY_MEDIUM);	
			}
		}
		
		/**
		 * User pressed log out button
		 */ 
		public function logoutClick(event:MouseEvent):void
		{
			disconnectUserSignal.dispatch(DisconnectEnum.CONNECTION_STATUS_USER_LOGGED_OUT);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			userSession.userList.userChangeSignal.remove(userChangeHandler);
			
			view.shareCameraButton.removeEventListener(MouseEvent.CLICK, onShareCameraClick);
			view.shareMicButton.removeEventListener(MouseEvent.CLICK, onShareMicClick);
			view.raiseHandButton.removeEventListener(MouseEvent.CLICK, onRaiseHandClick);
			view.cameraQualityRadioGroup.removeEventListener(ItemClickEvent.ITEM_CLICK, onCameraQualityRadioGroupClick);
			view.logoutButton.removeEventListener(MouseEvent.CLICK, logoutClick);
			
			view.dispose();
			view = null;
		}
	}
}
