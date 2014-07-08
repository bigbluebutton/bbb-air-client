package org.bigbluebutton.core
{
	import org.flexunit.asserts.assertTrue;
	
	public class UsersMessageSenderTest
	{		
		protected var instance:UsersMessageSender;
		
		[Before]
		public function setUp():void
		{
			instance = new UsersMessageSender();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUsersMessageSender():void
		{
			assertTrue("instance is UsersMessageSender", instance is UsersMessageSender);
		}
	}
}