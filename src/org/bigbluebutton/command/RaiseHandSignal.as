package org.bigbluebutton.command
{
	import org.osflash.signals.Signal;

	public class RaiseHandSignal extends Signal
	{
		public function RaiseHandSignal()
		{
			/**
			 * @1 handRaised
			 * @2 userId
			 */
			super(Boolean, String);
		}
	}
}