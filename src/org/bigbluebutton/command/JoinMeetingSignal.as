package org.bigbluebutton.command {
	
	import org.osflash.signals.Signal;
	
	public class JoinMeetingSignal extends Signal {
		public function JoinMeetingSignal() {
			super(String);
		}
	}
}
