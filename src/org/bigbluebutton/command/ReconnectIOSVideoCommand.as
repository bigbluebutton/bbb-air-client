package org.bigbluebutton.command
{
	import org.bigbluebutton.model.IUserSession;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ReconnectIOSVideoCommand extends Command
	{
		[Inject]
		public var userSession:IUserSession; 
		
		public override function execute():void
		{
			userSession.videoConnection.connectIOS();
		}
	}
}