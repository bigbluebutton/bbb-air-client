package org.bigbluebutton.core
{
	import org.bigbluebutton.model.chat.ChatMessageVO;
	import org.osflash.signals.ISignal;

	public interface IChatMessageService
	{
		
		function get sendPublicMessageOnSucessSignal():ISignal;
		function get sendPublicMessageOnFailureSignal():ISignal;
		function get sendPrivateMessageOnSucessSignal():ISignal;
		function get sendPrivateMessageOnFailureSignal():ISignal;

		function setupMessageSenderReceiver():void;
		function getPublicChatMessages():void;
		function sendPublicMessage(message:ChatMessageVO):void;
		function sendPrivateMessage(message:ChatMessageVO):void;
		function sendWelcomeMessage():void;
	}
}