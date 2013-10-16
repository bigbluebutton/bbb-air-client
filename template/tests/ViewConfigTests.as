package 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.notNullValue;
	
	import robotlegs.bender.framework.api.IConfig;

	public class ViewConfigTests
	{
		/**
		 * Tests that the TodoFormConfig class implements IConfig.
		 */
		[Test]
		public function implements_expectedInterface(): void
		{
			assertThat(new ViewConfig() as IConfig, notNullValue());
		}
	}
}