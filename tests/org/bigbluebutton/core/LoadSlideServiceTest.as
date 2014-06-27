package org.bigbluebutton.core
{
	import flash.events.Event;
	
	import mockolate.prepare;
	
	import org.bigbluebutton.model.presentation.Slide;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	public class LoadSlideServiceTest
	{		
		[Mock]
		public var slide:Slide;
		
		private static var TIMEOUT:Number = 5000;
		
		protected var instance:LoadSlideService;
		
		[Before(async)]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			Async.proceedOnEvent(this, prepare(Slide), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new LoadSlideService(slide);
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Ignore]
		[Test]
		public function instantiated_isInstanceOfLoadSlideService():void
		{
			assertTrue("instance is LoadSlideService", instance is LoadSlideService);
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}
