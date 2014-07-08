package org.bigbluebutton.core.util
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	
	public class VectorUtilTest
	{		
		protected var instance:VectorUtil;
		
		[Before]
		public function setUp():void
		{
			instance = new VectorUtil();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfVectorUtil():void
		{
			assertTrue("instance is VectorUtil", instance is VectorUtil);
		}
	}
}
