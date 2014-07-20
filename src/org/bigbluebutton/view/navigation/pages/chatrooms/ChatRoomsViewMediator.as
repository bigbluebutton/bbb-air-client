package org.bigbluebutton.view.navigation.pages.chatrooms
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.resources.ResourceManager;

	import org.bigbluebutton.core.IChatMessageService;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserSession;
	import org.bigbluebutton.model.chat.ChatMessage;
	import org.bigbluebutton.model.chat.ChatMessageVO;
	import org.bigbluebutton.model.chat.ChatMessages;
	import org.bigbluebutton.model.chat.IChatMessagesSession;
	import org.bigbluebutton.model.chat.PrivateChatMessage;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.bigbluebutton.view.navigation.pages.TransitionAnimationENUM;
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
		public var userSession: IUserSession;
		
		[Inject]
		public var chatMessagesSession: IChatMessagesSession;
		
		[Inject]
		public var userUISession: IUserUISession;
		protected var dataProvider:ArrayCollection;
		protected var usersSignal:ISignal; 
		protected var list:List;
		
		protected var dicUsertoChat:Dictionary;
		
		protected var button:Object;
		
		private var _users:ArrayCollection; 
		private var _usersAdded:Array = new Array();
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			dicUsertoChat = new Dictionary();
			
			dataProvider = new ArrayCollection();
			dataProvider.addItem({name: ResourceManager.getInstance().getString('resources', 'chat.item.publicChat'), publicChat:true, user:null, chatMessages: chatMessagesSession.publicChat});
			
			for each(var chatObject:PrivateChatMessage in chatMessagesSession.privateChats)
			{
				chatObject.userOnline = userSession.userList.hasUser(chatObject.userID);
				chatObject.privateChat.chatMessageChangeSignal.add(populateList);
				
				if(chatObject.privateChat.messages.length > 0)
				{
					addChat({name: chatObject.userName, publicChat:false, user: userSession.userList.getUser(chatObject.userID), chatMessages: chatObject.privateChat, userID: chatObject.userID, online: chatObject.userOnline });	
				}
				
			}
			
			button = {button:true};
			dataProvider.addItem(button);
			
			list = view.list;
			list.dataProvider = dataProvider;
			
			list.addEventListener(IndexChangeEvent.CHANGE, onIndexChangeHandler);
			
			// userSession.userlist.userChangeSignal.add(userChanged);
			// userSession.userList.userAddedSignal.add(newUserAdded);
			
			chatMessagesSession.publicChat.chatMessageChangeSignal.add(refreshList);
			
			userSession.userList.userRemovedSignal.add(userRemoved);
			userSession.userList.userAddedSignal.add(userAdded);
			
			chatMessagesSession.chatMessageChangeSignal.add(newMessageReceived);
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'chat.title');
			FlexGlobals.topLevelApplication.backBtn.visible = FlexGlobals.topLevelApplication.backBtn.includeInLayout = false;
			FlexGlobals.topLevelApplication.profileBtn.visible = FlexGlobals.topLevelApplication.profileBtn.includeInLayout = true;
		}
		
		/**
		 * When new message is received, add user to private messages and subscribe to messages update
		 * */
		public function newMessageReceived(userID:String):void
		{
			var user:User = userSession.userList.getUser(userID);
			
			var pcm:PrivateChatMessage = chatMessagesSession.getPrivateMessages(user.userID, user.name);
			
			pcm.privateChat.chatMessageChangeSignal.add(populateList);
			
			if(pcm.privateChat.messages.length > 0)
			{
				addChat({name: pcm.userName, publicChat:false, user: user, chatMessages: pcm.privateChat, userID: pcm.userID, online: true }, dataProvider.length-1);	
			}
		}
		
		/**
		 * if user removed, sets online property to false and updates data provider
		 **/
		public function userRemoved(userID:String):void
		{
			var userLeft:Object = getItemFromDataProvider(userID);
			if (userLeft != null)
			{
				userLeft.online=false;
				dataProvider.itemUpdated(userLeft);
			}
		}
		
		/**
		 * if user removed, sets online property to true and updates data provider
		 **/
		public function userAdded(user:Object):void
		{
			var userAdded:Object = getItemFromDataProvider(user.userID);
			if (userAdded != null)
			{
				userAdded.online=true;
				dataProvider.itemUpdated(userAdded);
			}
		}
		
		/**
		 * Get item from data provider based on user id
		 **/
		public function getItemFromDataProvider(UserID:String):Object
		{			
			for(var i:int = 0; i < dataProvider.length; i++)
			{
				if (dataProvider.getItemAt(i).userID == UserID)
				{
					return dataProvider.getItemAt(i);
				}
			}
			
			return null;
		}
		
		/*
		When new message is being added to public chat, we only need to refresh data provider
		*/
		public function refreshList(UserID:String = null):void
		{
			dataProvider.refresh();
		}
		
		/**
		 * Populate ArrayCollection after a new message was received 
		 * 
		 * @param UserID
		 */
		public function populateList(UserID:String = null):void
		{
			var newUser:User = userSession.userList.getUserByUserId(UserID);
			
			if((newUser != null) && (!isExist(newUser)) && (!newUser.me))
			{	
				var pcm:PrivateChatMessage = chatMessagesSession.getPrivateMessages(newUser.userID, newUser.name);
				addChat({name: pcm.userName, publicChat:false, user: newUser, chatMessages: pcm.privateChat, userID: pcm.userID, online: true}, dataProvider.length-1);			
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
		
		/**
		 * Check if User was already added to the data provider
		 **/
		private function userAlreadyAdded(userID:String):Boolean
		{
			for each(var str:String in _usersAdded)
			{
				if (userID == str)
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * If user wasn't already added, adding to the data provider
		 **/
		private function addChat(chat:Object, pos:Number = NaN):void
		{
			if (!userAlreadyAdded(chat.userID))
			{
				_usersAdded.push(chat.userID);
				
				if(isNaN(pos))
				{
					dataProvider.addItem(chat);
				}
				else
				{
					dataProvider.addItemAt(chat, pos);
				}		
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
					userUISession.pushPage(PagesENUM.SELECT_PARTICIPANT, item, TransitionAnimationENUM.SLIDE_LEFT)
				}
				else
				{
					userUISession.pushPage(PagesENUM.CHAT, item, TransitionAnimationENUM.SLIDE_LEFT)
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
			//userSession.userList.userAddedSignal.remove(addChat);
			//userSession.userlist.userRemovedSignal.add(userRemoved);
			
			chatMessagesSession.publicChat.chatMessageChangeSignal.remove(refreshList);
			userSession.userList.userRemovedSignal.remove(userRemoved);
			userSession.userList.userAddedSignal.remove(userAdded);
			chatMessagesSession.chatMessageChangeSignal.remove(newMessageReceived);
			
			list.removeEventListener(IndexChangeEvent.CHANGE, onIndexChangeHandler);
			
			//view.sendButton.removeEventListener(MouseEvent.CLICK, onSendButtonClick);
			
			view.dispose();
			view = null;
		}
	}
}