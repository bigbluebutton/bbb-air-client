package org.bigbluebutton.command {
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	public class MicrophoneEnableSignalTests {
		
		/**
		 * TurnOffMicSignal should not have an argument.
		 */
		[Test]
		public function default_ShouldHaveStringAsArg():void {
			assertThat(new MicrophoneOnSignal().valueClasses.length, equalTo(2));
		}
	}
}
