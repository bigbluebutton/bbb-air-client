package org.bigbluebutton.core.util
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class URLFetcherTest
	{		
		protected var instance:URLFetcher;
		
		[Before]
		public function setUp():void
		{
			instance = new URLFetcher();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfURLFetcher():void
		{
			assertTrue("instance is URLFetcher", instance is URLFetcher);
		}
	}
}