package org.bigbluebutton.model
{
	import org.flexunit.asserts.assertTrue;
	
	public class ConfigTest
	{		
		protected var instance:Config;
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new Config(new XML());
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfConfig():void
		{
			assertTrue("instance is Config", instance is Config);
		}
	}
}