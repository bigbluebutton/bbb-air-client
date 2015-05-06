package org.bigbluebutton.command {
	
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class MicrophoneMuteCommand extends Command {
		
		[Inject]
		public var user:User;
		
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var userService:IUsersService;
		
		override public function execute():void {
			trace("MicrophoneMuteCommand.execute() - user.muted = " + user.muted);
			if (user != null) {
				if (user.muted) {
					userService.unmute(user);
				} else {
					userService.mute(user);
				}
			}
		}
	}
}
