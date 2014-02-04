package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.resources.ResourceManager;
	
	import org.bigbluebutton.command.CameraEnableSignal;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserSettings;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ProfileViewMediator extends Mediator
	{
		[Inject]
		public var view: IProfileView;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userSettings: IUserSettings;
		
		[Inject]
		public var cameraEnabledSignal: CameraEnableSignal;

		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			userSettings.cameraChangeSignal.add(onCameraSettingChange)
			
			view.userNameText.text = userSession.userlist.getUser(userSession.userId).name;
			
			view.cameraOnOFFText.text = ResourceManager.getInstance().getString('resources', userSettings.cameraEnabled? 'profile.settings.camera.on':'profile.settings.camera.off'); 
						
			view.cameraButton.addEventListener(MouseEvent.CLICK, onCameraClick);
		}
		
		private function onCameraSettingChange(cameraEnabled:Boolean):void
		{
			view.cameraOnOFFText.text = ResourceManager.getInstance().getString('resources', cameraEnabled? 'profile.settings.camera.on':'profile.settings.camera.off'); 
		}
		
		protected function onCameraClick(event:MouseEvent):void
		{
			cameraEnabledSignal.dispatch(!userSettings.cameraEnabled);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			userSettings.cameraChangeSignal.remove(onCameraSettingChange)
			
			view.cameraButton.removeEventListener(MouseEvent.CLICK, onCameraClick);
			
			view.dispose();
			view = null;
		}
	}
}