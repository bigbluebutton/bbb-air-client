package org.bigbluebutton
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.notNullValue;
	
	import robotlegs.bender.framework.api.IConfig;

	public class AppConfigurationTests
	{
		/**
		 * Tests that the AppConfiguration implements IConfig.
		 */
		[Test]
		public function implements_expectedInterface(): void
		{
			assertThat(new AppConfig() as IConfig, notNullValue());
		}
	}
}