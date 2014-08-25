package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.events.MouseEvent;
	import flash.media.Camera;
	import flash.media.CameraPosition;
	
	import mx.core.FlexGlobals;
	import mx.events.ItemClickEvent;
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.command.CameraQualitySignal;
	import org.bigbluebutton.command.DisconnectUserSignal;
	import org.bigbluebutton.command.RaiseHandSignal;
	import org.bigbluebutton.command.ShareCameraSignal;
	import org.bigbluebutton.command.ShareMicrophoneSignal;
	import org.bigbluebutton.core.VideoConnection;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.LockSettings;
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
			userSession.userList.applyPresenterModeratorLockSettingsSignal.add(applyPresenterModeratorLockSettings);
			userSession.userList.applyViewerLockSettingsSignal.add(applyViewerLockSettings);
			
			var userMe:User = userSession.userList.me;		
			
			view.userNameText.text = userMe.name;		

			if(userSession.userList.me.role == User.MODERATOR || userSession.userList.me.presenter)
			{
				applyPresenterModeratorLockSettings();
			}
			else
			{
				applyViewerLockSettings();
			}
			
			view.shareCameraButton.addEventListener(MouseEvent.CLICK, onShareCameraClick);
			view.shareMicButton.addEventListener(MouseEvent.CLICK, onShareMicClick);
			view.raiseHandButton.addEventListener(MouseEvent.CLICK, onRaiseHandClick);
			view.cameraQualityRadioGroup.addEventListener(ItemClickEvent.ITEM_CLICK, onCameraQualityRadioGroupClick);
			view.setCameraQualityGroupVisibility(userSession.userList.me.hasStream);
			view.setCameraQuality(userSession.videoConnection.selectedCameraQuality);
			view.logoutButton.addEventListener(MouseEvent.CLICK, logoutClick);
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'profile.title');
		}
		
		private function userChangeHandler(user:User, type:int):void
		{
			if (user.me) {
				if (type == UserList.JOIN_AUDIO) {
					view.shareMicButton.label = ResourceManager.getInstance().getString('resources', user.voiceJoined ? 'profile.settings.mic.on' : 'profile.settings.mic.off');
					
					// These lock settings checks very ugly. The setting of the labels for shareMicButton/shareCameraButton should proabably be factored out, since they are set
					// by lock settings being changed, AND user status being changed... however I will leave it ugly, since the UI is being redone anyways. I will wait to 
					// see what changes I have to merge in first, before making it not-ugly... -- Adam
					
					if(!(userSession.userList.me.role == User.MODERATOR || userSession.userList.me.presenter) && userSession.lockSettings.disableMic) {
						view.shareMicButton.label += ResourceManager.getInstance().getString('resources', 'lockSettings.lockedLabel');
					}
				} else if (type == UserList.HAS_STREAM) {
					view.shareCameraButton.label = ResourceManager.getInstance().getString('resources', user.hasStream ? 'profile.settings.camera.on' : 'profile.settings.camera.off');
					view.setCameraQualityGroupVisibility(user.hasStream);
					
					if(!(userSession.userList.me.role == User.MODERATOR || userSession.userList.me.presenter) && userSession.lockSettings.disableCam) {
						view.shareCameraButton.label += ResourceManager.getInstance().getString('resources', 'lockSettings.lockedLabel');
					}
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
		
		private function applyPresenterModeratorLockSettings():void
		{
			var lockSettings:LockSettings = userSession.lockSettings;
			
			if(Camera.getCamera() != null)
			{
				view.shareCameraButton.enabled = true;
				view.shareCameraButton.label = ResourceManager.getInstance().getString('resources', userSession.userList.me.hasStream? 'profile.settings.camera.on':'profile.settings.camera.off');
			}
			else
			{
				view.shareCameraButton.enabled = false;
				view.shareCameraButton.label = ResourceManager.getInstance().getString('resources', 'profile.settings.camera.unavailable');
			}
			
			view.shareMicButton.enabled = true;
			view.shareMicButton.label = ResourceManager.getInstance().getString('resources', userSession.userList.me.voiceJoined ? 'profile.settings.mic.on' : 'profile.settings.mic.off');
		}
		
		private function applyViewerLockSettings():void
		{
			var lockSettings:LockSettings = userSession.lockSettings;

			if(Camera.getCamera() != null)
			{
				view.shareCameraButton.enabled = !lockSettings.disableCam;
				view.shareCameraButton.label = ResourceManager.getInstance().getString('resources', userSession.userList.me.hasStream? 'profile.settings.camera.on':'profile.settings.camera.off');
				
				if(lockSettings.disableCam)
				{
					view.shareCameraButton.label += ResourceManager.getInstance().getString('resources', 'lockSettings.lockedLabel');
				}
			}
			else
			{
				view.shareCameraButton.enabled = false;
				view.shareCameraButton.label = ResourceManager.getInstance().getString('resources', 'profile.settings.camera.unavailable');
			}
			
			view.shareMicButton.enabled = !lockSettings.disableMic;
			view.shareMicButton.label = ResourceManager.getInstance().getString('resources', userSession.userList.me.voiceJoined ? 'profile.settings.mic.on' : 'profile.settings.mic.off');
			
			if(lockSettings.disableMic)
			{
				view.shareMicButton.label += ResourceManager.getInstance().getString('resources', 'lockSettings.lockedLabel');
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			userSession.userList.userChangeSignal.remove(userChangeHandler);
			userSession.userList.applyPresenterModeratorLockSettingsSignal.remove(applyPresenterModeratorLockSettings);
			userSession.userList.applyViewerLockSettingsSignal.remove(applyViewerLockSettings);
			
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
