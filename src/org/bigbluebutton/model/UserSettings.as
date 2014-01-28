package org.bigbluebutton.model
{
	import org.bigbluebutton.command.CameraEnableSignal;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class UserSettings implements IUserSettings
	{
		public function UserSettings()
		{
			
		}

		private var _cameraChangeSignal: Signal = new Signal();
		
		/**
		 * Dispatched when the collection is
		 * changed.
		 */
		public function get cameraChangeSignal(): ISignal
		{
			return _cameraChangeSignal;
		}
		
		protected var _cameraEnabled:Boolean;
		
		public function get cameraEnabled():Boolean
		{
			return _cameraEnabled;
		}
		
		public function set cameraEnabled(value:Boolean):void
		{
			_cameraEnabled = value;
			_cameraChangeSignal.dispatch(_cameraEnabled);
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