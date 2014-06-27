package org.bigbluebutton.view.ui.loading
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class LoadingScreenTest
	{		
		protected var instance:LoadingScreen;
		
		[Before]
		public function setUp():void
		{
			instance = new LoadingScreen();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfLoadingScreen():void
		{
			assertTrue("instance is LoadingScreen", instance is LoadingScreen);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
		
		[Test]
		public function instantiated_implementsILoadingScreen():void
		{
			assertTrue("instance implements ILoadingScreen", instance is ILoadingScreen);
		}
	}
}