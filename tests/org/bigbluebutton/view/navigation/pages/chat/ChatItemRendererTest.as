package org.bigbluebutton.view.navigation.pages.chat
{
	import flash.events.Event;
	
	import flashx.textLayout.debug.assert;
	
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	
	import org.bigbluebutton.model.chat.ChatMessage;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.object.IsNullMatcher;
	import org.hamcrest.object.nullValue;
	
	import spark.components.supportClasses.ItemRenderer;
	
	public class ChatItemRendererTest
	{		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		private static var TIMEOUT:Number = 5000;
		
		[Mock]
		public var chatMessage:ChatMessage;
		
		protected var instance:ChatItemRenderer;
		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(ChatMessage), Event.COMPLETE, TIMEOUT, timeoutHandler)
			instance = new ChatItemRenderer();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatItemRenderer():void
		{
			assertTrue("instance is ChatItemRenderer", instance is ChatItemRenderer);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark ItemRenderer component", instance is ItemRenderer);
		}
		
		[Test]
		public function setDataMethodCalledWhenChatMessageIsNull_MessageTextIsEmpty():void
		{
			// Arrange
			chatMessage = null;
			
			// Act
			instance.data = chatMessage;
			
			// Assert
			assertTrue("If ChatMessage object is null, ChatItemRender's message text property should be empty", instance.message.text == ""); 
		}	
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}