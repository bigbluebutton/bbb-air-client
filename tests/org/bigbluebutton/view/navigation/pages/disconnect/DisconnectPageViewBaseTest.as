package org.bigbluebutton.view.navigation.pages.disconnect
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class DisconnectPageViewBaseTest
	{		
		protected var instance:DisconnectPageViewBase;
		
		[Before]
		public function setUp():void
		{
			instance = new DisconnectPageViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDisconnectPageViewBase():void
		{
			assertTrue("instance is DisconnectPageViewBase", instance is DisconnectPageViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}
