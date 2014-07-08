package org.bigbluebutton.model
{
	import flash.events.Event;
	
	import org.flexunit.asserts.assertTrue;

	public class ConnectionFailedEventTest
	{		
		protected var instance:ConnectionFailedEvent;
		
		[Before]
		public function setUp():void
		{
			// TODO : Provide valid constructor parameters relevant to the test
			instance = new ConnectionFailedEvent("testEvent");
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfConnectionFailedEvent():void
		{
			assertTrue("instance is ConnectionFailedEvent", instance is ConnectionFailedEvent);
		}
		
		[Test]
		public function instantiated_isInstanceOfEvent():void
		{
			assertTrue("instance is Event", instance is Event);
		}
	}
}