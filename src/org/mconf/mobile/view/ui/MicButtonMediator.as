package org.mconf.mobile.view.ui
{
	import org.mconf.mobile.command.MicrophoneEnableSignal;
	import org.mconf.mobile.model.IUserSettings;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MicButtonMediator extends Mediator
	{
		[Inject]
		public var userSettings: IUserSettings;
		
		[Inject]
		public var microphoneEnableSignal: MicrophoneEnableSignal;
				
		[Inject]
		public var view: IMicButton;
		
		/**
		 * Initialize listeners and Mediator initial state
		 */
		override public function initialize():void
		{
			Log.getLogger("org.mconf.mobile").info(String(this));
			
			view.turnOnMicSignal.add(turnOn);
			view.turnOffMicSignal.add(turnOff);
			
			userSettings.changedSignal.add(update);
			
			view.selected = userSettings.microphoneEnabled;
		}
		
		/**
		 * Destroy view and listeners
		 */
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			
			view = null;
			
			userSettings.changedSignal.remove(update);
		}
		
		/**
		 * Handle events to turnOn microphone
		 */
		private function turnOn(): void
		{
			microphoneEnableSignal.dispatch(true);
		}

		/**
		 * Handle events to turnOff microphone
		 */
		private function turnOff(): void
		{
			microphoneEnableSignal.dispatch(false);
		}
		
		/**
		 * Update the view when there is a chenge in the model
		 */ 
		private function update(value:Boolean):void
		{
			view.selected = value;
		}
	}
}