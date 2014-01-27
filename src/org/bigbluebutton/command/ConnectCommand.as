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
	
	public class ConnectCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var connection: IBigBlueButtonConnection;
		
		[Inject]
		public var joinVoiceSignal: JoinVoiceSignal;
		
		[Inject]
		public var videoConnection: IVideoConnection;
		
		[Inject]
		public var uri: String;
		
		[Inject]
		public var usersService: IUsersService;
		
		[Inject]
		public var chatService: IChatMessageService;

		[Inject]
		public var cameraEnableSignal: CameraEnableSignal;

		override public function execute():void {
			connection.uri = uri;
			
			connection.successConnected.add(successConnected)
			connection.unsuccessConnected.add(unsuccessConnected)

			connection.connect(conferenceParameters);
		}

		private function successConnected():void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":successConnected()");
			
			userSession.mainConnection = connection;
			userSession.userId = connection.userId;

			userUISession.loading = false;
			userUISession.pushPage(PagesENUM.PARTICIPANTS); 
			
			videoConnection.uri = userSession.config.getConfigFor("VideoConfModule").@uri + "/" + conferenceParameters.room;
			
			//TODO use proper callbacks
			//TODO see if videoConnection.successConnected is dispatched when it's connected properly
			videoConnection.successConnected.add(successVideoConnected);
			videoConnection.unsuccessConnected.add(unsuccessVideoConnected);
			
			videoConnection.connect();
			userSession.videoConnection = videoConnection;

			usersService.connectUsers(uri);
			usersService.connectListeners(uri);
			
			chatService.getPublicChatMessages();

			joinVoiceSignal.dispatch();
		}
		
		private function unsuccessConnected(reason:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":unsuccessConnected()");
			
			userUISession.loading = false;
		}
		
		private function successVideoConnected():void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":successVideoConnected()");
			
			//TODO this is a temporary location to enable the camera
			// put this signal in the handling of the enable camera button 
			cameraEnableSignal.dispatch(true);
		}
		
		private function unsuccessVideoConnected(reason:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":unsuccessVideoConnected()");
		}
	}
}