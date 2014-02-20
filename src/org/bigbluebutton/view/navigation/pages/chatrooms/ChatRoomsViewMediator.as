package org.bigbluebutton.view.navigation.pages.chatrooms
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.resources.ResourceManager;
	
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
		
		protected var dicUsertoChat:Dictionary;
		
		protected var button:Object;
		
		private var _users:ArrayCollection; 
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			dicUsertoChat = new Dictionary();
			
			dataProvider = new ArrayCollection();
			dataProvider.addItem({name: ResourceManager.getInstance().getString('resources', 'chat.item.publicChat'), publicChat:true, user:null, chatMessages: userSession.publicChat});
			
			_users = userSession.userList.users;
			
			for each(var user:User in _users)
			{			
				if(!user.me)
				{
					user.privateChat.chatMessageChangeSignal.add(populateList);
					if(user.privateChat.messages.length > 0)
					{
						addChat({name: user.name, publicChat:false, user:user, chatMessages: user.privateChat, userID: user.userID });	
					}	
				}
			}
			
			button = {button:true};
			dataProvider.addItem(button);
			
			list = view.list;
			list.dataProvider = dataProvider;
			
			list.addEventListener(IndexChangeEvent.CHANGE, onIndexChangeHandler);
			
			// userSession.userlist.userChangeSignal.add(userChanged);
			userSession.userList.userAddedSignal.add(addChat);
			
			userSession.publicChat.chatMessageChangeSignal.add(populateList);
			
			//userSession.userlist.userRemovedSignal.add(userRemoved);
		}
		
		/**
		 * Populate ArrayCollection after a new message was received 
		 * 
		 * @param UserID
		*/
		public function populateList(UserID:String = null):void
		{
			var newUser:User = userSession.userList.getUserByUserId(UserID);

			if((newUser != null) && (!isExist(newUser)))
			{
				addChat({name: newUser.name, publicChat:false, user:newUser, chatMessages: newUser.privateChat, userID: newUser.userID}, dataProvider.length-1);
			}
			
			dataProvider.refresh();
		}	
		
		/**
		 * Check if User is already added to the dataProvider 
		 * 
		 * @param User
		 */
		private function isExist(user:User):Boolean
		{		
			for(var i:int = 0; i< dataProvider.length; i++)
			{
				if (dataProvider.getItemAt(i).userID == user.userID)
				{
					return true;
				}
			}
			return false;	
		}
		
		private function addChat(chat:Object, pos:Number = NaN):void
		{
			if(isNaN(pos))
			{
				dataProvider.addItem(chat);
			}
			else
			{
				dataProvider.addItemAt(chat, pos);
			}
			
			//dataProvider.setItemAt(button, dataProvider.length-1);
			dataProvider.refresh();
			//dicUsertoChat[chat.user] = chat;		
		}
		
		/*		
		private function userRemoved(userID:String):void
		{
		var user:User = dicUsertoChat[userID] as User;
		var index:uint = dataProvider.getItemIndex(user);
		dataProvider.removeItemAt(index);
		dicUsertoChat[user.userID] = null;
		}
		*/		
		private function userChanged(user:User, property:String = null):void
		{
			dataProvider.refresh();
		}
		
		protected function onIndexChangeHandler(event:IndexChangeEvent):void
		{
			
			var item:Object = dataProvider.getItemAt(event.newIndex);
			if(item)
			{
				if(item.hasOwnProperty("button"))
				{
					userUISession.pushPage(PagesENUM.SELECT_PARTICIPANT, item)
				}
				else
				{
					userUISession.pushPage(PagesENUM.CHAT, item)
				}
			}
			else
			{
				throw new Error("item null on ChatRoomsViewMediator");
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
			
			//userSession.userlist.userChangeSignal.add(userChanged);
			userSession.userList.userAddedSignal.remove(addChat);
			//userSession.userlist.userRemovedSignal.add(userRemoved);
			
			list.removeEventListener(IndexChangeEvent.CHANGE, onIndexChangeHandler);
			
			//			view.sendButton.removeEventListener(MouseEvent.CLICK, onSendButtonClick);
			
			view.dispose();
			view = null;
		}
	}
}