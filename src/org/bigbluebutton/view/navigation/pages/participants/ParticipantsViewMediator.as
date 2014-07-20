package org.bigbluebutton.view.navigation.pages.participants
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.resources.ResourceManager;

	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.bigbluebutton.view.navigation.pages.TransitionAnimationENUM;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	public class ParticipantsViewMediator extends Mediator
	{
		[Inject]
		public var view: IParticipantsView;
		
		[Inject]
		public var userSession: IUserSession
		
		[Inject]
		public var userUISession: IUserUISession

		
		protected var dataProvider:ArrayCollection;
		protected var dicUserIdtoUser:Dictionary
		protected var usersSignal:ISignal; 
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));

			dataProvider = new ArrayCollection();
			view.list.dataProvider = dataProvider;
			
			view.list.addEventListener(IndexChangeEvent.CHANGE, onSelectParticipant);
			
			dicUserIdtoUser = new Dictionary();
			
			var users:ArrayCollection = userSession.userList.users;
			for each (var user:User in users) 
			{				
				addUser(user)
			}
			
			userSession.userList.userChangeSignal.add(userChanged);
			userSession.userList.userAddedSignal.add(addUser);
			userSession.userList.userRemovedSignal.add(userRemoved);
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'participants.title');
			FlexGlobals.topLevelApplication.backBtn.visible = FlexGlobals.topLevelApplication.backBtn.includeInLayout = false;
			FlexGlobals.topLevelApplication.profileBtn.visible = FlexGlobals.topLevelApplication.profileBtn.includeInLayout = true;
		}
		
		private function addUser(user:User):void
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
		
		protected function onSelectParticipant(event:IndexChangeEvent):void
		{
			if (event.newIndex >= 0) {
				var user:User = dataProvider.getItemAt(event.newIndex) as User;
				userUISession.pushPage(PagesENUM.USER_DETAIS, user, TransitionAnimationENUM.SLIDE_LEFT);
			}
		}
			
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			view = null;
			
			userSession.userList.userChangeSignal.remove(userChanged);
			userSession.userList.userAddedSignal.remove(addUser);
			userSession.userList.userRemovedSignal.remove(userRemoved);
		}
	}
}