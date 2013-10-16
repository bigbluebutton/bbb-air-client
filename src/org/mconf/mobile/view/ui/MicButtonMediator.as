package org.mconf.mobile.view.ui
{
	import org.mconf.mobile.command.MicrophoneEnableSignal;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MicButtonMediator extends Mediator
	{
		[Inject]
		public var microphoneEnableSignal: MicrophoneEnableSignal;
				
		[Inject]
		public var view: IMicButton;
		
		
		override public function initialize():void
		{
			Log.getLogger("org.mconf.mobile").info(String(this));
			
			view.turnOnMicSignal.add(turnOn);
			view.turnOffMicSignal.add(turnOff);
			
			//todoCollection.changedSignal.add(setTodosOnView);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			
			view = null;
		}
		
		/**
		 * Cancels the adding or modifying of 
		 * a todo.
		 */
		private function turnOn(): void
		{
			microphoneEnableSignal.dispatch(view, true);
		}

		/**
		 * Cancels the adding or modifying of 
		 * a todo.
		 */
		private function turnOff(): void
		{
			microphoneEnableSignal.dispatch(view, false);
		}
	}
}