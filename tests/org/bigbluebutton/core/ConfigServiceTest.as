package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class ConfigServiceTest
	{		
		protected var instance:ConfigService;
		
		[Before]
		public function setUp():void
		{
			instance = new ConfigService();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfConfigService():void
		{
			assertTrue("instance is ConfigService", instance is ConfigService);
		}
	}
}