package org.bigbluebutton.command
{
	import org.bigbluebutton.core.IDeskshareService;
	import org.bigbluebutton.model.IConferenceParameters;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class CheckDeskshareStreamCommand extends Command
	{
		[Inject]
		public var deskshareService: IDeskshareService;
		
		[Inject]
		public var conferenceParameters:IConferenceParameters;
		
		public override function execute():void
		{
			trace("Checking if Desk Share stream is streaming.");
			deskshareService.checkIfStreamIsPublishing(conferenceParameters.room);
		}
	}
}