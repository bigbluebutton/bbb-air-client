package org.mconf.mobile.command
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class MicrophoneEnableSignalTests
	{
		/**
		 * TurnOffMicSignal should not have an argument.
		 */
		[Test]
		public function default_ShouldHaveStringAsArg(): void
		{
			assertThat(new MicrophoneEnableSignal().valueClasses.length, equalTo(2));
		}
	}
}