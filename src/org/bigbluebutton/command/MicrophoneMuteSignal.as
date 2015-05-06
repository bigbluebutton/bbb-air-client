package org.bigbluebutton.command {
	
	import org.bigbluebutton.model.User;
	import org.osflash.signals.Signal;
	
	public class MicrophoneMuteSignal extends Signal {
		public function MicrophoneMuteSignal() {
			/**
			 * @1 microphone enabled
			 */
			super(User);
		}
	}
}
