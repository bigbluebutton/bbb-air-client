package org.bigbluebutton.command
{
	import org.osflash.signals.Signal;
	
	public class CameraEnableSignal extends Signal
	{
		public function CameraEnableSignal()
		{
			/**
			 * @1 camera enabled
			 */
			super(Boolean);
		}
	}
}