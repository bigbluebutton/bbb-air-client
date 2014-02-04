package org.bigbluebutton.core
{
	import org.bigbluebutton.model.chat.ChatMessageVO;
	import org.osflash.signals.Signal;

	public interface IChatMessageSender
	{
		function getPublicChatMessages():void
		function sendPublicMessage(message:ChatMessageVO):void
		function sendPrivateMessage(message:ChatMessageVO):void
			
		function get publicChatMessagesOnSucessSignal():Signal
		function get publicChatMessagesOnFailureSignal():Signal
		function get sendPublicMessageOnSucessSignal():Signal
		function get sendPublicMessageOnFailureSignal():Signal
		function get sendPrivateMessageOnSucessSignal():Signal
		function get sendPrivateMessageOnFailureSignal():Signal
	}
}