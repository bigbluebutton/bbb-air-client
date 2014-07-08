package org.bigbluebutton.view.navigation.pages.chat
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mockolate.arg;
	import mockolate.expect;
	import mockolate.prepare;
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.core.anything;
	
	import spark.components.Button;
	import spark.components.View;
	
	public class ChatViewTest
	{	
		protected var instance:ChatView;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatView();
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function instantiated_isInstanceOfChatView():void
		{
			assertTrue("instance is ChatView", instance is ChatView);
		}
		
		[Test]
		public function instantiated_isSparkComponent():void
		{
			assertTrue("instance is Spark View component", instance is View);
		}
		
		[Test]
		public function instantiated_implementsIChatView():void
		{
			assertTrue("instance implements IChatView", instance is IChatView);
		}
	}
}