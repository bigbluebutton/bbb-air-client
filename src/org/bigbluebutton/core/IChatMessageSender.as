package org.bigbluebutton.core
{
	import org.bigbluebutton.model.chat.ChatMessageVO;

	public interface IChatMessageSender
	{
		function getPublicChatMessages():void
		function sendPublicMessage(message:ChatMessageVO):void
		function sendPrivateMessage(message:ChatMessageVO):void
	}
}