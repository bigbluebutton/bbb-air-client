package org.bigbluebutton.model.chat
{
	import mx.collections.ArrayCollection;
	
	public interface IChatMessagesSession
	{
		function getPrivateMessagesByUserId(userId:String):PrivateChatMessage;
		function sendPrivateMessagesByUserId(userId:String, newMessage:ChatMessageVO):void;
		function addUserToPrivateMessages(userId:String, userName:String):void;
		function get publicChat():ChatMessages;
		function set publicChat(value:ChatMessages):void;
		function get privateChats():ArrayCollection;
	}
}