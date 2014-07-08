package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IMessageListener;
	import org.flexunit.asserts.assertTrue;
	
	public class PresentMessageReceiverTest
	{		
		protected var instance:PresentMessageReceiver;
		
		[Before]
		public function setUp():void
		{
			instance = new PresentMessageReceiver();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPresentMessageReceiver():void
		{
			assertTrue("instance is PresentMessageReceiver", instance is PresentMessageReceiver);
		}
		
		[Test]
		public function instantiated_implementsIMessageListener():void
		{
			assertTrue("instance implements IMessageListener", instance is IMessageListener);
		}
	}
}