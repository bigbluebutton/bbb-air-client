package org.mconf.mobile.command
{
	import flash.utils.setTimeout;
	
	import mx.utils.ObjectUtil;
	
	import org.mconf.mobile.core.IBigBlueButtonConnection;
	import org.mconf.mobile.core.IUsersService;
	import org.mconf.mobile.core.IVoiceConnection;
	import org.mconf.mobile.core.VoiceStreamManager;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.model.IUserUISession;
	import org.mconf.mobile.view.navigation.pages.PagesENUM;
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
			Log.getLogger("org.mconf.mobile").info(String(this) + ":mediaSuccessConnected()");
			
			userSession.voiceConnection = voiceConnection;
			
			var manager:VoiceStreamManager = new VoiceStreamManager();
			manager.play(voiceConnection.connection, playName);
			manager.publish(voiceConnection.connection, publishName, codec);			
			userSession.voiceStreamManager = manager;
		}
		
		private function mediaUnsuccessConnected(reason:String):void {
			Log.getLogger("org.mconf.mobile").info(String(this) + ":mediaUnsuccessConnected()");
		}
	}
}