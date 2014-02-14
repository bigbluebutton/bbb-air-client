package org.bigbluebutton.view.navigation.pages.selectparticipant
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.IndexChangedEvent;
	
	import org.bigbluebutton.core.IUsersServiceSO;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.osflash.signals.ISignal;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	import spark.events.ListEvent;
	
	public class SelectParticipantViewMediator extends Mediator
	{
		[Inject]
		public var view: ISelectParticipantView;
		
		[Inject]
		public var userSession: IUserSession
		
		[Inject]
		public var userUISession: IUserUISession;
		
		[Inject]
		public var usersServiceSO: IUsersServiceSO;
		
		protected var dataProvider:ArrayCollection;
		protected var dicUserIdtoUser:Dictionary
		protected var usersSignal:ISignal; 
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));

			dataProvider = new ArrayCollection();
			view.list.dataProvider = dataProvider;
			view.list.addEventListener(IndexChangeEvent.CHANGE, onSelectUser);			
			
			dicUserIdtoUser = new Dictionary();
			
			var users:ArrayCollection = userSession.userList.users;
			for each (var user:User in users) 
			{				
				if(!user.me)
				{
					userAdded(user)
				}
					
			}
			
			userSession.userList.userChangeSignal.add(userChanged);
			userSession.userList.userAddedSignal.add(userAdded);
			userSession.userList.userRemovedSignal.add(userRemoved);
		}
		
		private function userAdded(user:User):void
		{
			dataProvider.addItem(user);		
			dataProvider.refresh();
			dicUserIdtoUser[user.userID] = user;
		}
		
		private function userRemoved(userID:String):void
		{
			var user:User = dicUserIdtoUser[userID] as User;
			var index:uint = dataProvider.getItemIndex(user);
			dataProvider.removeItemAt(index);
			dicUserIdtoUser[user.userID] = null;
		}
		
		private function userChanged(user:User, property:String = null):void
		{
			dataProvider.refresh();
		}
		
		protected function onSelectUser(event:IndexChangeEvent):void
		{
			var user:User = dataProvider.getItemAt(event.newIndex) as User;
			userUISession.pushPage(PagesENUM.CHAT, user);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			view = null;
			
			userSession.userList.userChangeSignal.remove(userChanged);
			userSession.userList.userAddedSignal.remove(userAdded);
			userSession.userList.userRemovedSignal.remove(userRemoved);
		}
	}
}