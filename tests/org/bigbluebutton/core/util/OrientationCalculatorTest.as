package org.bigbluebutton.core.util
{
	import org.flexunit.asserts.assertTrue;
	
	import spark.components.View;
	import flash.display.DisplayObject;
	
	public class OrientationCalculatorTest
	{		
		protected var instance:OrientationCalculator;
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new OrientationCalculator(new DisplayObject(), testFunction);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Ignore]
		[Test]
		public function instantiated_isInstanceOfOrientationCalculator():void
		{
			assertTrue("instance is OrientationCalculator", instance is OrientationCalculator);
		}
		
		private function testFunction():void
		{
			
		}
	}
}