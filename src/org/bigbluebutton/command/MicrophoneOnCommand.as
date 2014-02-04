package org.bigbluebutton.command
{
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserSettings;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class MicrophoneOnCommand extends Command
	{		
		[Inject]
		public var userSettings: IUserSettings;
				
		[Inject]
		public var enabled: Boolean;
		
		[Inject]
		public var onUserRequest:Object;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userService: IUsersService;
		
		override public function execute():void
		{
			trace("MicrophoneEnableCommand.execute() - userSettings.microphoneEnabled = "+userSettings.microphoneEnabled);
			
			//TODO the model update should came only on server update!
			// update model
			userSettings.microphoneEnabled = enabled;

			if (onUserRequest as Boolean) {
				if (enabled) {
					userService.muteMe();
				} else {
					userService.unmuteMe();
				}
			} else {
				// update model
//				userSettings.microphoneEnabled = enabled;
			}
		}
	}
}