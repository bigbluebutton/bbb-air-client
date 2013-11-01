package org.bigbluebutton.view.ui
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.notNullValue;
	
	import robotlegs.bender.framework.api.IConfig;

	public class MicButtonConfigTests
	{
		/**
		 * Tests that the TodoFormConfig class implements IConfig.
		 */
		[Test]
		public function implements_expectedInterface(): void
		{
			assertThat(new MicButtonConfig() as IConfig, notNullValue());
		}
	}
}