package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IMessageListener;
	import org.flexunit.asserts.assertTrue;
	
	public class UsersMessageReceiverTest
	{		
		protected var instance:UsersMessageReceiver;
		
		[Before]
		public function setUp():void
		{
			instance = new UsersMessageReceiver();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUsersMessageReceiver():void
		{
			assertTrue("instance is UsersMessageReceiver", instance is UsersMessageReceiver);
		}
		
		[Test]
		public function instantiated_implementsIMessageListener():void
		{
			assertTrue("instance implements IMessageListener", instance is IMessageListener);
		}
	}
}
