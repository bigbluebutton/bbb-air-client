package org.bigbluebutton.view.navigation.pages.chatrooms
{
	import flash.events.Event;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	
	import org.bigbluebutton.model.chat.ChatMessages;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import spark.components.supportClasses.ItemRenderer;
	
	public class ChatRoomsItemRendererTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		private static var TIMEOUT:Number = 5000;
		
		[Mock]
		public var chatMessages:ChatMessages;
		
		protected var instance:ChatRoomsItemRenderer;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(ChatMessages), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new ChatRoomsItemRenderer();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatRoomsItemRenderer():void
		{
			assertTrue("instance is ChatRoomsItemRenderer", instance is ChatRoomsItemRenderer);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark ItemRenderer component", instance is ItemRenderer);
		}
		
		[Test]
		public function setDataMethodCalledWhenChatMessagesIsNull_TitleTextIsEmpty():void
		{
			// Arrange
			chatMessages = null;
			
			// Act
			instance.data = chatMessages;
			
			// Assert
			assertTrue("If ChatMessages object is null, ChatRoomsItemRenderer's message text property should be empty", instance.title.text == ""); 
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}
