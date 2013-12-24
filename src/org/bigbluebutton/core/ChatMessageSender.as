package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.chat.ChatMessageVO;

	public class ChatMessageSender implements IChatMessageSender
	{
		[Inject]
		public var userSession: IUserSession;

		public function getPublicChatMessages():void
		{  
			trace("Sending [chat.getPublicMessages] to server.");
			userSession.mainConnection.sendMessage("chat.sendPublicChatHistory", 
				function(result:String):void { // On successful result
					trace(result); 
				},	                   
				function(status:String):void { // status - On error occurred
					trace(status); 
				}
			);
		}
		
		public function sendPublicMessage(message:ChatMessageVO):void
		{  
			trace("Sending [chat.sendPublicMessage] to server. [" + message.message + "]");
			userSession.mainConnection.sendMessage("chat.sendPublicMessage", 
				function(result:String):void { // On successful result
					trace(result); 
				},	                   
				function(status:String):void { // status - On error occurred
					trace(status); 
				},
				message.toObj()
			);
		}
		
		public function sendPrivateMessage(message:ChatMessageVO):void
		{  
			trace("Sending [chat.sendPrivateMessage] to server.");
			trace("Sending fromUserID [" + message.fromUserID + "] to toUserID [" + message.toUserID + "]");
			userSession.mainConnection.sendMessage("chat.sendPrivateMessage", 
				function(result:String):void { // On successful result
					trace(result); 
				},	                   
				function(status:String):void { // status - On error occurred
					trace(status); 
				},
				message.toObj()
			);
		}
	}
}