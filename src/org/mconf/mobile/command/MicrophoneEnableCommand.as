package org.mconf.mobile.command
{
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.model.IUserSettings;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class MicrophoneEnableCommand extends Command
	{		
		[Inject]
		public var userSettings: IUserSettings;
				
		[Inject]
		public var enabled: Boolean;
		
		[Inject]
		public var onUserRequest:Boolean;
		
		[Inject]
		public var userSession: IUserSession;
		
		override public function execute():void
		{
			// update model
			userSettings.microphoneEnabled = enabled;
			trace("MicrophoneEnableCommand.execute() - userSettings.microphoneEnabled = "+userSettings.microphoneEnabled);
			
			// \TODO implement the remote mute and unmute
/*
			if (onUserRequest) {
				if (enabled) {
					userSession.voiceConnection.unmute();
				} else {
					userSession.voiceConnection.mute();
				}
			}
*/
		}
	}
}