package org.mconf.mobile.command
{
	import org.osflash.signals.Signal;
	
	public class PlayAudioStreamSignal extends Signal
	{
		public function PlayAudioStreamSignal()
		{
			super(String, String);
		}
	}
}