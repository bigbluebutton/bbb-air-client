package org.bigbluebutton.command {
	
	import org.osflash.signals.Signal;
	
	public class AuthenticationSignal extends Signal {
		public function AuthenticationSignal() {
			super(String);
		}
	}
}
