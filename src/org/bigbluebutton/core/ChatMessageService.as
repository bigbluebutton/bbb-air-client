package org.bigbluebutton.core
{
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IMessageListener;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.chat.ChatMessageVO;

	public class ChatMessageService implements IChatMessageService
	{
		[Inject]
		public var chatMessageReceiver: IChatMessageReceiver;
		
		[Inject]
		public var chatMessageSender: IChatMessageSender;

		[Inject]
		public var userSession: IUserSession;

		public function getPublicChatMessages():void {
			userSession.mainConnection.addMessageListener(chatMessageReceiver as IMessageListener);
			chatMessageSender.getPublicChatMessages();
		}
		
		public function sendPublicMessage(message:ChatMessageVO):void {
			chatMessageSender.sendPublicMessage(message);
		}
		
		public function sendPrivateMessage(message:ChatMessageVO):void {
			chatMessageSender.sendPrivateMessage(message);
		}
	}
}