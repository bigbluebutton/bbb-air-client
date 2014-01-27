package org.bigbluebutton.command
{
	import flash.media.Camera;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IChatMessageService;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.core.IVideoConnection;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class CameraEnableCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;

		[Inject]
		public var enabled: Boolean;

		[Inject]
		public var usersService: IUsersService;
		
		override public function execute():void {
			if (enabled) {
				enableCamera();
			} else {
				disableCamera();
			}
		}
		
		private function buildStreamName(camWidth:int, camHeight:int, userId:String):String {
			var d:Date = new Date();
			var curTime:Number = d.getTime();	
			var uid:String = userSession.userId;
			var res:String = camWidth + "x" + camHeight;
			return res.concat("-" + uid) + "-" + curTime;
		}
		
		private function setupCamera():Camera {
			var camera:Camera = Camera.getCamera();
			camera.setMode(160, 120, 5);
			return camera;
		}
		
		private function enableCamera():void {
			var camera:Camera = setupCamera();
			var userId:String = userSession.userId;
			var streamName:String = buildStreamName(camera.width, camera.height, userId);
			
			usersService.addStream(userId, streamName);
			userSession.videoConnection.startPublishing(camera, streamName);
		}
		
		private function disableCamera():void {
			usersService.removeStream(userSession.userId, "");
			userSession.videoConnection.stopPublishing();
		}
	}
}