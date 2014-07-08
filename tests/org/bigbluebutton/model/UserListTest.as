package org.bigbluebutton.model
{
	import flash.events.Event;
	
	import org.flexunit.asserts.assertTrue;
	import org.osflash.signals.Signal;
	
	public class UserListTest
	{		
		protected var instance:UserList;
		
		[Before]
		public function setUp():void
		{
			instance = new UserList();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfUserList():void
		{
			assertTrue("instance is UserList", instance is UserList);
		}
		
		[Test]
		public function listenerRemoved_numberOfListenersIsNull():void
		{	
			// Arrange
			instance.userChangeSignal.add(listener);
			
			// Act
			instance.userChangeSignal.remove(listener);
			
			// Assert
			assertTrue("view is destroyed when mediator is destroyed", instance.userChangeSignal.numListeners == 0);
		}
		
		[Test]
		public function listenerAdded_numberOfListenersIsNotNull():void
		{	
			// Act
			instance.userChangeSignal.add(listener);
			
			// Assert
			assertTrue("view is destroyed when mediator is destroyed", instance.userChangeSignal.numListeners != 0);
		}
		
		private function listener(e : Event) : void
		{
		}
	}
}
