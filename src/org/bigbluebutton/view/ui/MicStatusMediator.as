package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.model.IUserSettings;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MicStatusMediator extends Mediator
	{
		[Inject]
		public var userSettings: IUserSettings;

		[Inject]
		public var view: IMicStatus;
		
		/**
		 * Initialize listeners and Mediator initial state
		 */
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			userSettings.changedSignal.add(update);
			
			view.micEnabled = userSettings.microphoneEnabled;
		}
		
		/**
		 * Update the view when there is a chenge in the model
		 */ 
		private function update(value:Boolean):void
		{
			view.micEnabled = value;
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
	}
}