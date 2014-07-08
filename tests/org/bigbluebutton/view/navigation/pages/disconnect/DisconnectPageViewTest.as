package org.bigbluebutton.view.navigation.pages.disconnect
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class DisconnectPageViewTest
	{		
		protected var instance:DisconnectPageView;
		
		[Before]
		public function setUp():void
		{
			instance = new DisconnectPageView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfDisconnectPageView():void
		{
			assertTrue("instance is DisconnectPageView", instance is DisconnectPageView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIDisconnectPageView():void
		{
			assertTrue("instance implements IDisconnectPageView", instance is IDisconnectPageView);
		}
	}
}