package org.bigbluebutton.model
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class UserSettings implements IUserSettings
	{
		public function UserSettings()
		{
			
		}
		
		private var _changedSignal: Signal = new Signal();
		
		protected var _microphoneEnabled:Boolean;
		
		public function get microphoneEnabled():Boolean
		{
			return _microphoneEnabled;
		}

		public function set microphoneEnabled(value:Boolean):void
		{
			_microphoneEnabled = value;
			changedSignal.dispatch(_microphoneEnabled);
		}

		/**
		 * Dispatched when the collection is
		 * changed.
		 */
		public function get changedSignal(): ISignal
		{
			return _changedSignal;
		}

	}
}