package org.bigbluebutton.model.chat
{
	import mx.collections.ArrayCollection;
	
	public class ChatMessagesSession implements IChatMessagesSession
	{
		private var _publicChat:ChatMessages = new ChatMessages();
		private var _privateChats:ArrayCollection = new ArrayCollection();
		
		public function set publicChat(value:ChatMessages):void
		{
			_publicChat = value;
		}
		
		public function get publicChat():ChatMessages
		{
			return _publicChat;
		}
		
		public function get privateChats():ArrayCollection
		{
			return _privateChats;
		}
		
		/**
		 * Create private chat for the new user 
		 * 
		 * */
		public function addUserToPrivateMessages(userId:String, userName:String):void
		{
			var pcm:PrivateChatMessage = new PrivateChatMessage();
			pcm.userID = userId;
			pcm.userName = userName;
			_privateChats.addItem(pcm);
		}
		
		/**
		 * Send private messages to a specific user based on a UserId 
		 * 
		 * @param UserId
		 * @param newMessage
		 */
		public function sendPrivateMessagesByUserId(userId:String, newMessage:ChatMessageVO):void
		{
			if (_privateChats != null)
			{
				for each(var privateMessage:PrivateChatMessage in _privateChats)
				{	
					if (privateMessage.userID == userId)
					{
						privateMessage.privateChat.newChatMessage(newMessage);
					}
				}
			}
		}
		
		/**
		 * Get a private chat messages based on a UserId 
		 * 
		 * @param UserId
		 */
		public function getPrivateMessagesByUserId(userId:String):PrivateChatMessage
		{
			if (_privateChats != null)
			{
				for each(var privateMessage:PrivateChatMessage in _privateChats)
				{	
					if (privateMessage.userID == userId)
					{
						return privateMessage;
					}
				}
			}
			
			return null;		
		}
	}
}