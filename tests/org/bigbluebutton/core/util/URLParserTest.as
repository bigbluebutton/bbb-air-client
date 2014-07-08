package org.bigbluebutton.core.util
{
	import org.flexunit.asserts.assertTrue;
	
	public class URLParserTest
	{		
		protected var instance:URLParser;
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new URLParser("testString");
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Ignore]
		[Test]
		public function instantiated_isInstanceOfURLParser():void
		{
			assertTrue("instance is URLParser", instance is URLParser);
		}
	}
}