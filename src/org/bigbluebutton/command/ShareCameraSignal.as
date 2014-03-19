package org.bigbluebutton.command
{
	import org.osflash.signals.Signal;
	
	public class ShareCameraSignal extends Signal
	{
		public function ShareCameraSignal()
		{
			/**
			 * @1 camera enabled
			 */
			super(Boolean);
		}
	}
}