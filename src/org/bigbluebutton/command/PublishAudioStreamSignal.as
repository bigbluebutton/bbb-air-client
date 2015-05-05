package org.bigbluebutton.command {
	
	import org.osflash.signals.Signal;
	
	public class PublishAudioStreamSignal extends Signal {
		public function PublishAudioStreamSignal() {
			super(String, String);
		}
	}
}
