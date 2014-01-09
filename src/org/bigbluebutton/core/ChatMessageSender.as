package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.chat.ChatMessageVO;
	import org.osflash.signals.Signal;

	public class ChatMessageSender implements IChatMessageSender
	{
		[Inject]
		public var userSession: IUserSession;

		public function getPublicChatMessages():void
		{  
			trace("Sending [chat.getPublicMessages] to server.");
			userSession.mainConnection.sendMessage("chat.sendPublicChatHistory", 
				function(result:String):void { // On successful result
					publicChatMessagesOnSucessSignal.dispatch(result);
				},	                   
				function(status:String):void { // status - On error occurred
					publicChatMessagesOnFailureSignal.dispatch(status); 
				}
			);
		}
		
		public function sendPublicMessage(message:ChatMessageVO):void
		{  
			trace("Sending [chat.sendPublicMessage] to server. [" + message.message + "]");
			userSession.mainConnection.sendMessage("chat.sendPublicMessage", 
				function(result:String):void { // On successful result
					sendPublicMessageOnSucessSignal.dispatch(result);
				},	                   
				function(status:String):void { // status - On error occurred
					sendPublicMessageOnFailureSignal.dispatch(status); 
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
					sendPrivateMessageOnSucessSignal.dispatch(result);
				},	                   
				function(status:String):void { // status - On error occurred
					sendPrivateMessageOnFailureSignal.dispatch(status);
				},
				message.toObj()
			);
		}

		private var _publicChatMessagesOnSucessSignal:Signal = new Signal();
		private var _publicChatMessagesOnFailureSignal:Signal = new Signal();
		private var _sendPublicMessageOnSucessSignal:Signal = new Signal();
		private var _sendPublicMessageOnFailureSignal:Signal = new Signal();
		private var _sendPrivateMessageOnSucessSignal:Signal = new Signal();
		private var _sendPrivateMessageOnFailureSignal:Signal = new Signal();
		
		public function get publicChatMessagesOnSucessSignal():Signal
		{
			return _publicChatMessagesOnSucessSignal;
		}

		public function get publicChatMessagesOnFailureSignal():Signal
		{
			return _publicChatMessagesOnFailureSignal;
		}

		public function get sendPublicMessageOnSucessSignal():Signal
		{
			return _sendPublicMessageOnSucessSignal;
		}

		public function get sendPublicMessageOnFailureSignal():Signal
		{
			return _sendPublicMessageOnFailureSignal;
		}

		public function get sendPrivateMessageOnSucessSignal():Signal
		{
			return _sendPrivateMessageOnSucessSignal;
		}

		public function get sendPrivateMessageOnFailureSignal():Signal
		{
			return _sendPrivateMessageOnFailureSignal;
		}
	}
}