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
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
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
		
		/**
		 * Creates new instance of ChatMessageVO with Welcome message as message string
		 * and imitates new public message being sent
		 **/ 
		public function sendWelcomeMessage():void {
			
			// retrieve welcome message from conference parameters
			var welcome:String = conferenceParameters.welcome;
			
			if (welcome != "") {   		
				var msg:ChatMessageVO = new ChatMessageVO();
				msg.chatType = "PUBLIC_CHAT"
				msg.fromUserID = " ";
				msg.fromUsername = " ";
				msg.fromColor = "86187";
				msg.fromLang = "en";
				msg.fromTime = new Date().time;
				msg.fromTimezoneOffset = new Date().timezoneOffset;
				msg.toUserID = " ";
				msg.toUsername = " ";
				msg.message = welcome;
				
				// imitate new public message being sent
				chatMessageReceiver.onMessage("ChatReceivePublicMessageCommand", msg);			
			}
		}
	}
}