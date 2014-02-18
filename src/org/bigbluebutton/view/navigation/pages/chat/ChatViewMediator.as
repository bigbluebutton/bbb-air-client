package org.bigbluebutton.view.navigation.pages.chat
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import org.bigbluebutton.core.IChatMessageReceiver;
	import org.bigbluebutton.core.IChatMessageSender;
	import org.bigbluebutton.core.IChatMessageService;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.chat.ChatMessage;
	import org.bigbluebutton.model.chat.ChatMessageVO;
	import org.bigbluebutton.model.chat.ChatMessages;
	import org.osflash.signals.ISignal;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.List;
	
	public class ChatViewMediator extends Mediator
	{
		[Inject]
		public var view: IChatView;
		
		[Inject]
		public var chatMessageSender: IChatMessageSender;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		protected var dataProvider:ArrayCollection;
		protected var usersSignal:ISignal; 
		protected var list:List;
		protected var publicChat:Boolean = true;
		protected var user:User;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			var data:Object = userUISession.currentPageDetails;
			
			if(data is User)
			{
				createNewChat(data as User);
			}
			else
			{
				openChat(data);
			}

			chatMessageSender.sendPublicMessageOnSucessSignal.add(onSendSucess);
			chatMessageSender.sendPublicMessageOnFailureSignal.add(onSendFailure);
			
			chatMessageSender.sendPrivateMessageOnSucessSignal.add(onSendSucess);
			chatMessageSender.sendPrivateMessageOnFailureSignal.add(onSendFailure);
			
			list.addEventListener(FlexEvent.UPDATE_COMPLETE, scrollUpdate);
			
			view.sendButton.addEventListener(MouseEvent.CLICK, onSendButtonClick);
		}
		
		protected function createNewChat(user:User):void
		{
			publicChat = false;
			this.user = user;
			view.pageTitle.text = user.name;
			
			dataProvider = user.privateChat.messages;
			list = view.list;
			list.dataProvider = dataProvider;
		}
		
		protected function openChat(currentPageDetails:Object):void
		{
			publicChat = currentPageDetails.publicChat;
			user = currentPageDetails.user;
			view.pageTitle.text = currentPageDetails.name;
			
			var chatMessages:ChatMessages = currentPageDetails.chatMessages as ChatMessages;
			chatMessages.resetNewMessages();
			dataProvider = chatMessages.messages as ArrayCollection;
			list = view.list;
			list.dataProvider = dataProvider;
		}
				
		private function scrollUpdate(e:Event):void
		{		
			if (list.dataGroup.contentHeight > list.dataGroup.height)
			{
				list.dataGroup.verticalScrollPosition = list.dataGroup.contentHeight - list.dataGroup.height;
			}
		}
				
		private function onSendButtonClick(e:MouseEvent):void
		{
			view.inputMessage.enabled = false;
			view.sendButton.enabled = false;
			
			var currentDate:Date = new Date();
			
			//TODO get info from the right source
			var m:ChatMessageVO = new ChatMessageVO();
			
			m.fromUserID = userSession.userId;
			m.fromUsername = userSession.userList.getUser(userSession.userId).name;
			m.fromColor = "0";
			m.fromTime = currentDate.time;
			m.fromTimezoneOffset = currentDate.timezoneOffset;
			m.fromLang = "en";
			m.message = view.inputMessage.text;
			m.toUserID = publicChat?"public_chat_userid":user.userID;
			m.toUsername = publicChat?"public_chat_username":user.name;
			
			if(publicChat)
			{
				m.chatType = "PUBLIC_CHAT";
				chatMessageSender.sendPublicMessage(m);
			}
			else
			{
				m.chatType = "PRIVATE_CHAT";
				chatMessageSender.sendPrivateMessage(m);
			}
		}
		
		private function onSendSucess(result:String):void
		{
			view.inputMessage.enabled = true;
			view.inputMessage.text = "";
		}
		
		private function onSendFailure(status:String):void
		{
			view.inputMessage.enabled = true;
			view.sendButton.enabled = true;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			list.removeEventListener(FlexEvent.UPDATE_COMPLETE, scrollUpdate);
			
			view.sendButton.removeEventListener(MouseEvent.CLICK, onSendButtonClick);
			
			chatMessageSender.sendPublicMessageOnSucessSignal.remove(onSendSucess);
			chatMessageSender.sendPublicMessageOnFailureSignal.remove(onSendFailure);
			
			chatMessageSender.sendPrivateMessageOnSucessSignal.remove(onSendSucess);
			chatMessageSender.sendPrivateMessageOnFailureSignal.remove(onSendFailure);
			
			view.dispose();
			view = null;
		}
	}
}