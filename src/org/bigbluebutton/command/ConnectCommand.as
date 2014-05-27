package org.bigbluebutton.command
{
	import flash.media.Camera;
	
	import mx.messaging.management.Attribute;
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IChatMessageService;
	import org.bigbluebutton.core.IDeskshareConnection;
	import org.bigbluebutton.core.IDeskshareService;
	import org.bigbluebutton.core.IPresentationService;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.core.IVideoConnection;
	import org.bigbluebutton.core.IVoiceConnection;
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
		public var videoConnection: IVideoConnection;
		
		[Inject]
		public var voiceConnection: IVoiceConnection;
		
		[Inject]
		public var deskshareConnection : IDeskshareConnection;
		
		[Inject]
		public var uri: String;
		
		[Inject]
		public var usersService: IUsersService;
		
		[Inject]
		public var chatService: IChatMessageService;
		
		[Inject]
		public var presentationService: IPresentationService;
		
		[Inject]
		public var deskshareService: IDeskshareService;
		
		override public function execute():void {
			connection.uri = uri;
			
			connection.successConnected.add(successConnected);
			connection.unsuccessConnected.add(unsuccessConnected);
			
			connection.connect(conferenceParameters);
		}
		
		private function successConnected():void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":successConnected()");
			
			userSession.mainConnection = connection;
			userSession.userId = connection.userId;
			
			usersService.connectUsers(uri);
			
			videoConnection.uri = userSession.config.getConfigFor("VideoConfModule").@uri + "/" + conferenceParameters.room;
			
			//TODO use proper callbacks
			//TODO see if videoConnection.successConnected is dispatched when it's connected properly
			videoConnection.successConnected.add(successVideoConnected);
			videoConnection.unsuccessConnected.add(unsuccessVideoConnected);
			
			videoConnection.connect();
			userSession.videoConnection = videoConnection;
			
			voiceConnection.uri = userSession.config.getConfigFor("PhoneModule").@uri;
			userSession.voiceConnection = voiceConnection;
					
			usersService.connectListeners(uri);
			
			deskshareConnection.applicationURI = userSession.config.getConfigFor("DeskShareModule").@uri;
			deskshareConnection.connect();
	
			userSession.deskshareConnection = deskshareConnection;
			deskshareService.connectDeskshareSO();
			
			chatService.sendWelcomeMessage();
			chatService.getPublicChatMessages();

			userSession.userList.allUsersAddedSignal.add(successUsersAdded);
			
			presentationService.connectPresent(uri);
			
			connection.successConnected.remove(successConnected);
			connection.unsuccessConnected.remove(unsuccessConnected);
		}
		
		/**
		 * Raised when we receive signal from UserServiceSO.as that all participants were added. 
		 * Now we can switch from loading screen to participants screen
		 */
		private function successUsersAdded():void
		{
			userUISession.loading = false;
			userUISession.pushPage(PagesENUM.PARTICIPANTS);
			
			userSession.userList.allUsersAddedSignal.remove(successUsersAdded);
		}
		
		private function unsuccessConnected(reason:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":unsuccessConnected()");
			
			userUISession.loading = false;
			userUISession.unsuccessJoined.dispatch("connectionFailed");
			
			connection.successConnected.remove(successConnected);
			connection.unsuccessConnected.remove(unsuccessConnected);
		}
		
		private function successVideoConnected():void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":successVideoConnected()");
			
			videoConnection.successConnected.remove(successVideoConnected);
			videoConnection.unsuccessConnected.remove(unsuccessVideoConnected);
		}
		
		private function unsuccessVideoConnected(reason:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":unsuccessVideoConnected()");
			
			videoConnection.unsuccessConnected.remove(unsuccessVideoConnected);
			videoConnection.successConnected.remove(successVideoConnected);
		}
	}
}