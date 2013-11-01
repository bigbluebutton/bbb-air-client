package org.bigbluebutton.command
{
	import flash.utils.setTimeout;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.core.IVoiceConnection;
	import org.bigbluebutton.core.VoiceStreamManager;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class JoinVoiceCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var voiceConnection: IVoiceConnection;
		
		[Inject]
		public var mainConnection: IBigBlueButtonConnection;
		
		[Inject]
		public var usersService: IUsersService;

		override public function execute():void
		{
			voiceConnection.uri = userSession.config.getConfigFor("PhoneModule").@uri;
			voiceConnection.successConnected.add(mediaSuccessConnected);
			voiceConnection.unsuccessConnected.add(mediaUnsuccessConnected);
			voiceConnection.connect(conferenceParameters);
		}
		
		private function mediaSuccessConnected(publishName:String, playName:String, codec:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":mediaSuccessConnected()");
			
			userSession.voiceConnection = voiceConnection;
			
			var manager:VoiceStreamManager = new VoiceStreamManager();
			manager.play(voiceConnection.connection, playName);
			manager.publish(voiceConnection.connection, publishName, codec);			
			userSession.voiceStreamManager = manager;
		}
		
		private function mediaUnsuccessConnected(reason:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":mediaUnsuccessConnected()");
		}
	}
}