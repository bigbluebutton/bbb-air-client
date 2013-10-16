package org.mconf.mobile.command
{
	import org.mconf.mobile.model.IUserSettings;
	import org.mconf.mobile.view.ui.IMicButton;
	import org.mconf.mobile.view.ui.MicButton;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class MicrophoneEnableCommand extends Command
	{		
		[Inject]
		public var userSettings: IUserSettings;
		
		[Inject]
		public var button: MicButton;
				
		[Inject]
		public var boolean: Boolean;
		
		override public function execute():void
		{
			// update model
			userSettings.microphoneEnabled = boolean;
			
			//update view
			button.selected = boolean;
			
			trace("MicrophoneEnableCommand.execute() - button.selected = "+button.selected);
		}
	}
}