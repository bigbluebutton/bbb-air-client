package org.bigbluebutton.view.ui.loading
{
	import org.flexunit.asserts.assertTrue;
	
	public class ILoadingScreenTest
	{		
		protected var instance:ILoadingScreen;
		
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
	}
}