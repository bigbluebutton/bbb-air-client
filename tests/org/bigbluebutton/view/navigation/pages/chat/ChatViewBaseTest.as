package org.bigbluebutton.view.navigation.pages.chat
{
	import flash.events.MouseEvent;
	
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	
	import spark.components.Button;
	import spark.components.TextInput;
	import spark.components.View;
	
	public class ChatViewBaseTest
	{		
		protected var instance:ChatViewBase;
		
		[Before(async)]
		public function setUp():void
		{
			instance = new ChatViewBase();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatViewBase():void
		{
			assertTrue("instance is ChatViewBase", instance is ChatViewBase);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function inputMessageEmpty_sendButtonDisabled():void
		{
			// Arrange
			instance.sendButton0 = new Button();
			instance.inputMessage0 = new TextInput();
			
			// Act
			instance.inputMessage0.text = "";
			
			// Assert
			assertTrue(instance.sendButton0.enabled == false);
		}
		
		[Test]
		public function inputMessageNonEmpty_sendButtonEnabled():void
		{
			// Arrange
			instance.sendButton0 = new Button();
			instance.inputMessage0 = new TextInput();
			
			// Act
			instance.inputMessage0.text = "Test";
			
			// Assert
			assertTrue(instance.sendButton0.enabled == true);
		}
		
		protected function timeoutHandler(passThroughData:Object):void
		{
			fail("Timeout occured during setUp() method");
		}
	}
}