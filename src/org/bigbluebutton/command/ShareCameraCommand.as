package org.bigbluebutton.command
{
	import flash.media.Camera;
	import flash.media.CameraPosition;
	
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
	
	public class ShareCameraCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;

		[Inject]
		public var enabled: Boolean;
		
		[Inject]
		public var position: String;

		[Inject]
		public var usersService: IUsersService;
		
		[Inject]
		public var conferenceParameters:IConferenceParameters;
		
		override public function execute():void {
			if (enabled) {
				userSession.videoConnection.cameraPosition = position;
				enableCamera(position);
			} else {
				disableCamera();
			}
		}
		
		private function buildStreamName(camWidth:int, camHeight:int, userId:String, roomId:String):String {
			var d:Date = new Date();
			var curTime:Number = d.getTime();	
			var uid:String = userSession.userId;
			var res:String = camWidth + "x" + camHeight;
			return res.concat("-" + uid) + "-" + roomId + "-" + curTime;
		}
		
		private function setupCamera(position:String):Camera 
		{
			return findCamera(position);
			/*
			var camera:Camera = Camera.getCamera();
			if(camera)
			{
				camera.setMode(160, 120, 5);
			}
			return camera;
			*/
		}
		
		private function findCamera(position:String):Camera
		{
			if (!Camera.isSupported)
			{
				return null;
			}
			
			var cam:Camera = this.getCamera(position);
			
			
			/*
			cam.setMode(160, 120, 5, false);
			cam.setMotionLevel(0);
			this.video = new Video(this.videoDisplay.width, this.videoDisplay.height);
			var m:Matrix = new Matrix();
			m.rotate(Math.PI/2); // 90 degrees
			this.video.transform.matrix = m;
			this.video.attachCamera(cam);
			var uic:UIComponent = new UIComponent();
			uic.addChild(this.video);
			uic.x = ((videoDisplay.width/2) - (this.video.width/2)) + this.video.width;
			uic.y = ((videoDisplay.height/2) - (this.video.height/2)) - 50;
			this.videoDisplay.addElement(uic);
			*/
			return cam;
		}
		
		// Get the requested camera. If it cannot be found,
		// return the device's default camera.
		private function getCamera(position:String):Camera
		{
			for (var i:uint = 0; i < Camera.names.length; ++i)
			{
				var cam:Camera = Camera.getCamera(String(i));
				if (cam.position == position) return cam;
			}
			return Camera.getCamera();
		}
		
		private function enableCamera(position:String):void {
			userSession.videoConnection.camera = setupCamera(position);
			userSession.videoConnection.selectCameraQuality(userSession.videoConnection.selectedCameraQuality);	
			var userId:String = userSession.userId;
			
			if(userSession.videoConnection.camera)
			{
				var streamName:String = buildStreamName(userSession.videoConnection.camera.width, userSession.videoConnection.camera.height, userId, conferenceParameters.room);
				
				usersService.addStream(userId, streamName);
				userSession.videoConnection.startPublishing(userSession.videoConnection.camera, streamName);
			}
		}
		
		private function disableCamera():void {
			usersService.removeStream(userSession.userId, "");
			userSession.videoConnection.stopPublishing();
		}
	}
}