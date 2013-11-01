package org.mconf.mobile.command
{
	import org.osflash.signals.Signal;
	
	public class MicrophoneEnableSignal extends Signal
	{
		public function MicrophoneEnableSignal()
		{
			/**
			 * @1 microphone enabled
			 * @2 on user request
			 */
			super(Boolean, Boolean);
		}
	}
}