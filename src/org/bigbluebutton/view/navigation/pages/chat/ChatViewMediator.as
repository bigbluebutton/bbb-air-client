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
		
		protected var dataProvider:ArrayCollection;
		protected var usersSignal:ISignal; 
		protected var list:List;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			var chatMessages:ChatMessages = userSession.publicChat;
			dataProvider = chatMessages.messages;
			list = view.list;
			list.dataProvider = dataProvider;
			
			list.addEventListener(FlexEvent.UPDATE_COMPLETE, scrollUpdate);
			
			view.sendButton.addEventListener(MouseEvent.CLICK, onSendButtonClick);
		}
		
		private function scrollUpdate(e:Event):void
		{
			list.dataGroup.verticalScrollPosition = list.dataGroup.contentHeight - list.dataGroup.height;
		}
		
		
		private function onSendButtonClick(e:MouseEvent):void
		{
			view.inputMessage.enabled = false;
			view.sendButton.enabled = false;
			
			//TODO get info from the right source
			var m:ChatMessageVO = new ChatMessageVO();
			m.chatType = "PUBLIC";
			m.fromUserID = userSession.userId;
			m.fromUsername = "fromUsername";
			m.fromColor = "0";
			m.fromTime = 1389215529008;
			m.fromTimezoneOffset = 120;
			m.fromLang = "en";
			m.message = view.inputMessage.text;
			m.toUserID = "asdsadasda";
			m.toUsername = "fromUsername";
			
			chatMessageSender.sendPublicMessageOnSucessSignal.add(onSendSucess);
			chatMessageSender.sendPublicMessageOnFailureSignal.add(onSendFailure);
			chatMessageSender.sendPublicMessage(m);			
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
			
			view.dispose();
			view = null;
		}
	}
}