package org.mconf.mobile.command
{
	import org.mconf.mobile.model.IUserSettings;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class MicrophoneEnableCommand extends Command
	{		
		[Inject]
		public var userSettings: IUserSettings;
				
		[Inject]
		public var boolean: Boolean;
		
		override public function execute():void
		{
			// update model
			userSettings.microphoneEnabled = boolean;
			
			trace("MicrophoneEnableCommand.execute() - userSettings.microphoneEnabled = "+userSettings.microphoneEnabled);
		}
	}
}