package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class PresentMessageSenderTest
	{		
		protected var instance:PresentMessageSender;
		
		[Before]
		public function setUp():void
		{
			instance = new PresentMessageSender();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPresentMessageSender():void
		{
			assertTrue("instance is PresentMessageSender", instance is PresentMessageSender);
		}
	}
}