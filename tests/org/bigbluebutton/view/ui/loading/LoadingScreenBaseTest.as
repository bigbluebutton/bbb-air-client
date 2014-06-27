package org.bigbluebutton.view.ui.loading
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.Group;
	
	public class LoadingScreenBaseTest
	{		
		protected var instance:LoadingScreenBase;
		
		[Before]
		public function setUp():void
		{
			instance = new LoadingScreenBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfLoadingScreenBase():void
		{
			assertTrue("instance is LoadingScreenBase", instance is LoadingScreenBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark Group component", instance is Group);
		}
	}
}
