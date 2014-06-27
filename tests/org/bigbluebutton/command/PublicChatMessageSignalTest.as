package org.bigbluebutton.command
{
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.ISignal;

	public class PublicChatMessageSignalTest
	{		
		protected var instance:PublicChatMessage;
		
		[Before]
		public function setUp():void
		{
			instance = new PublicChatMessage();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfPublicChatMessage():void
		{
			assertTrue("instance is PublicChatMessage", instance is PublicChatMessage);
		}
		
		[Test]
		public function instantiated_implementsISignal():void
		{
			assertTrue("instance implements ISignal", instance is ISignal);
		}
	}
}