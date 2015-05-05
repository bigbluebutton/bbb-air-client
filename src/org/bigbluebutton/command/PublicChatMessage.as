package org.bigbluebutton.command {
	
	import org.osflash.signals.Signal;
	import org.bigbluebutton.model.chat.ChatMessage;
	
	public class PublicChatMessage extends Signal {
		public function PublicChatMessage() {
			/**
			 * @1
			 */
			super(ChatMessage);
		}
	}
}
