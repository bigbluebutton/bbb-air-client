package org.mconf.mobile.command
{
	import org.mconf.mobile.view.ui.MicButton;
	import org.osflash.signals.Signal;
	
	public class MicrophoneEnableSignal extends Signal
	{
		public function MicrophoneEnableSignal()
		{
			super(MicButton, Boolean);
		}
	}
}