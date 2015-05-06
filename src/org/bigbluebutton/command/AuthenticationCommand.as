package org.bigbluebutton.command {
	
	import org.bigbluebutton.model.IUserUISession;
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class AuthenticationCommand extends Command {
		
		[Inject]
		public var command:String;
		
		[Inject]
		public var userUISession:IUserUISession;
		
		public function AuthenticationCommand() {
			super();
		}
		
		override public function execute():void {
			switch (command) {
				case "timeOut":
					userUISession.loading = false;
					userUISession.unsuccessJoined.dispatch("authTokenTimedOut");
					break;
				case "invalid":
				default:
					userUISession.loading = false;
					userUISession.unsuccessJoined.dispatch("authTokenInvalid");
					break;
			}
		}
	}
}
