package org.bigbluebutton.command {
	
	import org.osflash.signals.Signal;
	
	public class NavigateToSignal extends Signal {
		public function NavigateToSignal() {
			super(String, Object, int);
		}
	}
}
