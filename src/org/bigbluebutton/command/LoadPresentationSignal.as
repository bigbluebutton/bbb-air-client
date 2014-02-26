package org.bigbluebutton.command
{
	import org.osflash.signals.Signal;

	public class LoadPresentationSignal extends Signal
	{
		public function LoadPresentationSignal()
		{
			/**
			 * @1 presentation name
			 */
			super(String);
		}
	}
}