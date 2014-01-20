package org.bigbluebutton.view.navigation.pages.chatrooms
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
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.osflash.signals.ISignal;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	import spark.events.ListEvent;
	
	public class ChatRoomsViewMediator extends Mediator
	{
		[Inject]
		public var view: IChatRoomsView;
		
		[Inject]
		public var chatMessageSender: IChatMessageSender;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		
		protected var dataProvider:ArrayCollection;
		protected var usersSignal:ISignal; 
		protected var list:List;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			dataProvider = new ArrayCollection();
			dataProvider.addItem({name: "Group Chat", publicChat:true, user:null, chatMessages: userSession.publicChat});
			
			var users:ArrayCollection = userSession.userlist.users;
			
			for each(var user:User in users)
			{
				if(user.privateChat.messages.length > 0 && !user.me)
				{
					dataProvider.addItem({name: user.name, publicChat:false, user:user, chatMessages: user.privateChat});
				}
			}
				
			list = view.list;
			list.dataProvider = dataProvider;
			
			list.addEventListener(IndexChangeEvent.CHANGE, onIndexChangeHandler);
		}
		
		protected function onIndexChangeHandler(event:IndexChangeEvent):void
		{
			var item:Object = dataProvider.getItemAt(event.newIndex);
			if(item)
			{
				userUISession.pushPage(PagesENUM.CHAT, item)
			}
		}
		
/*		
		private function onSendButtonClick(e:MouseEvent):void
		{
			view.inputMessage.enabled = false;
			view.sendButton.enabled = false;
			
			var currentDate:Date = new Date();
			
			//TODO get info from the right source
			var m:ChatMessageVO = new ChatMessageVO();
			m.chatType = "PUBLIC";
			m.fromUserID = userSession.userId;
			m.fromUsername = "XXfromUsernameXX";
			m.fromColor = "0";
			m.fromTime = currentDate.time;
			m.fromTimezoneOffset = currentDate.timezoneOffset;
			m.fromLang = "en";
			m.message = view.inputMessage.text;
			m.toUserID = "FAKE_USERID";
			m.toUsername = "XXfromUsernameXX";
			
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
*/		
		override public function destroy():void
		{
			super.destroy();
			
//			list.removeEventListener(FlexEvent.UPDATE_COMPLETE, scrollUpdate);
			
//			view.sendButton.removeEventListener(MouseEvent.CLICK, onSendButtonClick);
			
			view.dispose();
			view = null;
		}
	}
}