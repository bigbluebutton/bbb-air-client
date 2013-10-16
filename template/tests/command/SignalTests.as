package
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class SignalTests
	{
		/**
		 * Signal should not have an argument.
		 */
		[Test]
		public function default_ShouldHaveStringAsArg(): void
		{
			assertThat(new TurnOffMicSignal().valueClasses.length, equalTo(0));
		}
	}
}