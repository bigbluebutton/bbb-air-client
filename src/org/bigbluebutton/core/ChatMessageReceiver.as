package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.chat.ChatMessageVO;

	public class ChatMessageReceiver implements IChatMessageReceiver, IMessageListener
	{
		[Inject]
		public var userSession: IUserSession;

		public function onMessage(messageName:String, message:Object):void
		{
			switch (messageName) {
				case "ChatReceivePublicMessageCommand":
					handleChatReceivePublicMessageCommand(message);
					break;			
				case "ChatReceivePrivateMessageCommand":
					handleChatReceivePrivateMessageCommand(message);
					break;	
				case "ChatRequestMessageHistoryReply":
					handleChatRequestMessageHistoryReply(message);
					break;	
				default:
					//   LogUtil.warn("Cannot handle message [" + messageName + "]");
			}
		}
		
		private function handleChatRequestMessageHistoryReply(message:Object):void {
			var msgCount:Number = message.count as Number;
			for (var i:int = 0; i < msgCount; i++) {
				handleChatReceivePublicMessageCommand(message.messages[i]);
			}
		}
		
		private function handleChatReceivePublicMessageCommand(message:Object):void {
			trace("Handling public chat message [" + message.message + "]");
			var msg:ChatMessageVO = new ChatMessageVO();
			msg.chatType = message.chatType;
			msg.fromUserID = message.fromUserID;
			msg.fromUsername = message.fromUsername;
			msg.fromColor = message.fromColor;
			msg.fromLang = message.fromLang;
			msg.fromTime = message.fromTime;
			msg.fromTimezoneOffset = message.fromTimezoneOffset;
			msg.toUserID = message.toUserID;
			msg.toUsername = message.toUsername;
			msg.message = message.message;
			
			userSession.publicChat.newChatMessage(msg);
		}
		
		private function handleChatReceivePrivateMessageCommand(message:Object):void {
			trace("Handling private chat message");
			var msg:ChatMessageVO = new ChatMessageVO();
			msg.chatType = message.chatType;
			msg.fromUserID = message.fromUserID;
			msg.fromUsername = message.fromUsername;
			msg.fromColor = message.fromColor;
			msg.fromLang = message.fromLang;
			msg.fromTime = message.fromTime;
			msg.fromTimezoneOffset = message.fromTimezoneOffset;
			msg.toUserID = message.toUserID;
			msg.toUsername = message.toUsername;
			msg.message = message.message;
			
			var userId:String = (msg.fromUserID == userSession.userId? msg.toUserID: msg.fromUserID);
			userSession.userlist.getUser(userId).privateChat.newChatMessage(msg);
		}
	}
}