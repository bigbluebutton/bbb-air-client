package org.bigbluebutton.command
{
	import flash.utils.setTimeout;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.core.VoiceConnection;
	import org.bigbluebutton.core.VoiceStreamManager;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ShareMicrophoneCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var enabled: Boolean;

		private var voiceConnection:VoiceConnection;
		
		override public function execute():void
		{
			if (enabled) {
				enableMic();
			} else {
				disableMic();
			}
		}
		
		private function enableMic():void {
			voiceConnection = userSession.voiceConnection;
			
			if (voiceConnection == null) {
				voiceConnection = userSession.voiceConnection = new VoiceConnection();
				
				voiceConnection.uri = userSession.config.getConfigFor("PhoneModule").@uri;
				voiceConnection.successConnected.add(mediaSuccessConnected);
				voiceConnection.unsuccessConnected.add(mediaUnsuccessConnected);
				voiceConnection.connect(conferenceParameters);
			} else if (!voiceConnection.connection.connected) {
				voiceConnection.connect(conferenceParameters);
				voiceConnection.successConnected.add(mediaSuccessConnected);
				voiceConnection.unsuccessConnected.add(mediaUnsuccessConnected);
			} else if (!voiceConnection.callActive) {
				voiceConnection.call();
				voiceConnection.successConnected.add(mediaSuccessConnected);
				voiceConnection.unsuccessConnected.add(mediaUnsuccessConnected);
			}
		}
		
		private function disableMic():void {
			var manager:VoiceStreamManager = userSession.voiceStreamManager;
			
			if (manager != null) {
				manager.close();
			}
		}
		
		private function mediaSuccessConnected(publishName:String, playName:String, codec:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":mediaSuccessConnected()");
			
			var manager:VoiceStreamManager = new VoiceStreamManager();
			manager.play(voiceConnection.connection, playName);
			manager.publish(voiceConnection.connection, publishName, codec);			
			userSession.voiceStreamManager = manager;
			
			voiceConnection.successConnected.remove(mediaSuccessConnected);
			voiceConnection.unsuccessConnected.remove(mediaUnsuccessConnected);
		}
		
		private function mediaUnsuccessConnected(reason:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":mediaUnsuccessConnected()");
			voiceConnection.successConnected.remove(mediaSuccessConnected);
			voiceConnection.unsuccessConnected.remove(mediaUnsuccessConnected);
		}
	}
}