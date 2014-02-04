package org.bigbluebutton.command
{
	import org.osflash.signals.Signal;
	
	public class MicrophoneOnSignal extends Signal
	{
		public function MicrophoneOnSignal()
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