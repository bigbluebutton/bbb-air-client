package org.bigbluebutton.command
{
	import flash.utils.setTimeout;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.core.IBigBlueButtonConnection;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.core.IVoiceConnection;
	import org.bigbluebutton.core.VoiceConnection;
	import org.bigbluebutton.core.VoiceStreamManager;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ShareMicrophoneCommand extends Command
	{		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var audioOptions: Object;
		
		private var _shareMic:Boolean;
		private var _listenOnly:Boolean;
		
		private var voiceConnection:IVoiceConnection;
		
		override public function execute():void
		{
			getAudioOption(audioOptions);
			if (_shareMic || _listenOnly)
			{
				enableAudio();
			}
			else
			{
				disableAudio();
			}
		}
		
		private function getAudioOption(option:Object):void
		{
			if(option != null && option.hasOwnProperty("shareMic") && option.hasOwnProperty("listenOnly"))
			{
				_shareMic = option.shareMic;
				_listenOnly = option.listenOnly;
			}	
		}
		
		private function enableAudio():void {
			voiceConnection = userSession.voiceConnection;
			if (!voiceConnection.connection.connected) {
				voiceConnection.connect(conferenceParameters);
				voiceConnection.successConnected.add(mediaSuccessConnected);
				voiceConnection.unsuccessConnected.add(mediaUnsuccessConnected);
			}
			else if (!voiceConnection.callActive) {
				voiceConnection.call(_listenOnly);
				voiceConnection.successConnected.add(mediaSuccessConnected);
				voiceConnection.unsuccessConnected.add(mediaUnsuccessConnected);
			}
		}
		
		private function disableAudio():void {
			var manager:VoiceStreamManager = userSession.voiceStreamManager;
			voiceConnection = userSession.voiceConnection;
			if (manager != null) {
				manager.close();
				voiceConnection.hangUp();
			}
		}
		
		private function mediaSuccessConnected(publishName:String, playName:String, codec:String):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":mediaSuccessConnected()");
			
			var manager:VoiceStreamManager = new VoiceStreamManager();
			manager.play(voiceConnection.connection, playName);
			if(publishName != null && publishName.length != 0)
			{
				manager.publish(voiceConnection.connection, publishName, codec);
			}						
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