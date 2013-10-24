package org.mconf.mobile.command
{
	import org.osflash.signals.Signal;
	
	public class NavigateToPageSignal extends Signal
	{
		public function NavigateToPageSignal()
		{
			super(String, Object);
		}
	}
}