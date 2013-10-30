package org.mconf.mobile.command
{
	import org.osflash.signals.Signal;
	
	public class PublishAudioStreamSignal extends Signal
	{
		public function PublishAudioStreamSignal()
		{
			super(String, String);
		}
	}
}