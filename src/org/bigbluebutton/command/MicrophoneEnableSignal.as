package org.bigbluebutton.command
{
	import org.osflash.signals.Signal;
	
	public class MicrophoneEnableSignal extends Signal
	{
		public function MicrophoneEnableSignal()
		{
			//TODO use an AS Object with the two booleans as attributes
			/**
			 * @1 microphone enabled
			 * @2 on user request
			 */
			super(Boolean, Object);
		}
	}
}