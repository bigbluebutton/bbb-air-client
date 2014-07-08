package org.bigbluebutton.core.view
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class NoTabViewTest
	{		
		protected var instance:NoTabView;
		
		[Before]
		public function setUp():void
		{
			instance = new NoTabView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfNoTabView():void
		{
			assertTrue("instance is NoTabView", instance is NoTabView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
	}
}
