package org.bigbluebutton.command {
	
	import org.bigbluebutton.model.presentation.Slide;
	import org.osflash.signals.Signal;
	
	public class LoadSlideSignal extends Signal {
		public function LoadSlideSignal() {
			super(Slide);
		}
	}
}
