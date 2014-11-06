package org.bigbluebutton.model.chat
{
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class ChatMessageTest
	{	
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		protected var instance:ChatMessage;
		
		[Before]
		public function setUp():void
		{
			instance = new ChatMessage();
		}
		
		/* ChatMessage::toString tests */
		
		/* The behaviour of the ChatMessage::toString should be to strip XML tags from the chat message */
		[Test]
		public function toString_containsXMLTags_stripsTags():void
		{
			instance.name = "some-guy's-name";
			instance.time = "some-time";
			instance.translatedText = "<sometag>this is a chat message!!</sometag>";
			
			var noTagsString:String = instance.toString();
			
			/* toString() also adds stuff to the beginning and end of the translated text, which is why the safe string
			 * has the value that is does. The important part, is that the tags get stripped. */
			assertThat(noTagsString, equalTo("Chat message some-guy's-name said this is a chat message!! at some-time"));
		}
		
		[After]
		public function tearDown():void
		{
			instance = null;
		}
/*		
		[Test]
		public function instantiated_isInstanceOfChatMessage():void
		{
			assertTrue("instance is ChatMessage", instance is ChatMessage);
		}*/
	}
}