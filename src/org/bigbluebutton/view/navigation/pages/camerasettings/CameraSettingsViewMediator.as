package org.bigbluebutton.view.navigation.pages.camerasettings
{
	import flash.events.MouseEvent;
	import flash.media.Camera;
	import flash.media.CameraPosition;
	
	import mx.core.FlexGlobals;
	import mx.events.ItemClickEvent;
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.command.CameraQualitySignal;
	import org.bigbluebutton.command.ShareCameraSignal;
	import org.bigbluebutton.core.VideoConnection;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.LockSettings;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.view.ui.SwapCameraButton;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class CameraSettingsViewMediator extends Mediator
	{
		[Inject]
		public var view: ICameraSettingsView;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var shareCameraSignal: ShareCameraSignal;			
		
		[Inject]
		public var changeQualitySignal : CameraQualitySignal;
		
	
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			userSession.userList.userChangeSignal.add(userChangeHandler);
			userSession.applyPresenterModeratorLockSettingsSignal.add(applyPresenterModeratorLockSettings);
			userSession.applyViewerLockSettingsSignal.add(applyViewerLockSettings);
			
			var userMe:User = userSession.userList.me;
						
			if (userMe.role == User.MODERATOR || userMe.presenter)
			{
				applyPresenterModeratorLockSettings();
			}
			else
			{
				applyViewerLockSettings();
			}
			
			if (Camera.getCamera() == null)
			{
				view.startCameraButton.label = ResourceManager.getInstance().getString('resources', 'profile.settings.camera.unavailable');
				view.startCameraButton.enabled = false;
			}
			else
			{
				view.startCameraButton.label  = ResourceManager.getInstance().getString('resources', userMe.hasStream? 'profile.settings.camera.on':'profile.settings.camera.off');
			}
			if(Camera.names.length <= 1 )
			{
				setSwapCameraButtonEnable(false);
			}
			else
			{
				if(!userMe.hasStream)
				{
					setSwapCameraButtonEnable(false);
				}
				view.swapCameraButton.addEventListener(MouseEvent.CLICK, mouseClickHandler);
				userSession.userList.userChangeSignal.add(userChangeHandler);
			}
			view.startCameraButton.addEventListener(MouseEvent.CLICK, onShareCameraClick);
			view.cameraQualityRadioGroup.addEventListener(ItemClickEvent.ITEM_CLICK, onCameraQualityRadioGroupClick);
			view.setCameraQuality(userSession.videoConnection.selectedCameraQuality);
			setRadioGroupEnable(userMe.hasStream);
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'cameraSettings.title');
		}
		
		private function applyPresenterModeratorLockSettings():void
		{
			if (Camera.getCamera() != null) {
				view.startCameraButton.enabled = true;
			}
		}
		
		private function applyViewerLockSettings():void
		{
			if (Camera.getCamera() != null) {
				view.startCameraButton.enabled = !userSession.lockSettings.disableCam;
			}
		}
		
		private function userChangeHandler(user:User, type:int):void
		{
			if (user.me) {
				if (type == UserList.HAS_STREAM) {
					view.startCameraButton.label  = ResourceManager.getInstance().getString('resources', user.hasStream ? 'profile.settings.camera.on' : 'profile.settings.camera.off');
					setRadioGroupEnable(user.hasStream);
					if(Camera.names.length > 1)
					{
						setSwapCameraButtonEnable(user.hasStream)
					}
				}
			}
		}
		
		protected function onShareCameraClick(event:MouseEvent):void
		{
			view.setCameraQuality(VideoConnection.CAMERA_QUALITY_MEDIUM);
			userSession.videoConnection.selectedCameraQuality = VideoConnection.CAMERA_QUALITY_MEDIUM;	
			shareCameraSignal.dispatch(!userSession.userList.me.hasStream, CameraPosition.FRONT);
		}
		
		protected function setRadioGroupEnable(enabled:Boolean):void
		{
			view.cameraQualityRadioGroup.enabled=enabled;
		}
		
		protected function setSwapCameraButtonEnable(enabled:Boolean):void
		{
			view.swapCameraButton.enabled = enabled;
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
		 * Raised on button click, will send signal to swap camera source  
		 **/
		private function mouseClickHandler(e:MouseEvent):void
		{
			if (String(userSession.videoConnection.cameraPosition) == CameraPosition.FRONT)
			{
				shareCameraSignal.dispatch(userSession.userList.me.hasStream, CameraPosition.BACK);
			}
			else if (String(userSession.videoConnection.cameraPosition) == CameraPosition.BACK)
			{
				shareCameraSignal.dispatch(userSession.userList.me.hasStream, CameraPosition.FRONT);
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			userSession.userList.userChangeSignal.remove(userChangeHandler);		
			userSession.applyPresenterModeratorLockSettingsSignal.remove(applyPresenterModeratorLockSettings);
			userSession.applyViewerLockSettingsSignal.remove(applyViewerLockSettings);
			view.startCameraButton.removeEventListener(MouseEvent.CLICK, onShareCameraClick);
			if(Camera.names.length > 1)
			{
				view.swapCameraButton.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			}
			view.cameraQualityRadioGroup.removeEventListener(ItemClickEvent.ITEM_CLICK, onCameraQualityRadioGroupClick);			
			view.dispose();
			view = null;
		}
	}
}