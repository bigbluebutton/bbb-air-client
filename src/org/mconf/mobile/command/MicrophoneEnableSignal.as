package org.mconf.mobile.command
{
	import org.osflash.signals.Signal;
	
	public class MicrophoneEnableSignal extends Signal
	{
		public function MicrophoneEnableSignal()
		{
			super(Boolean);
		}
	}
}