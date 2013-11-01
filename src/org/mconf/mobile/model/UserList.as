package org.mconf.mobile.model
{
	import mx.collections.ArrayCollection;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	
	import spark.collections.Sort;

	public class UserList
	{
		private var _userJoinedSignal: Signal = new Signal();

		public function get userJoinedSignal():ISignal
		{
			return _userJoinedSignal;
		}
		
		private var _userLeftSignal: Signal = new Signal();
		
		public function get userLeftSignal():ISignal
		{
			return _userLeftSignal;
		}
		
		private var _userChangeSignal: Signal = new Signal();

		public function get userChangeSignal():ISignal
		{
			return _userChangeSignal;
		}
		
		private var _users:ArrayCollection;	
		[Bindable]
		public function get users():ArrayCollection
		{
			return _users;
		}

		private function set users(value:ArrayCollection):void
		{
			_users = value;
		}

		private var _me:User;

		public function get me():User
		{
			return _me;
		}

		private function set me(value:User):void
		{
			_me = value;
		}

		private var _sort:Sort;
		
		public function UserList()
		{
			_me = new User();
			_users = new ArrayCollection();
			_sort = new Sort();
			_sort.compareFunction = sortFunction;
			_users.sort = _sort;
		}
		
		// Custom sort function for the users ArrayCollection. Need to put dial-in users at the very bottom.
		private function sortFunction(a:Object, b:Object, array:Array = null):int {
			var au:User = a as User, bu:User = b as User;
			/*if (a.presenter)
			return -1;
			else if (b.presenter)
			return 1;*/
			if (au.role == User.MODERATOR && bu.role == User.MODERATOR) {
				// do nothing go to the end and check names
			} else if (au.role == User.MODERATOR)
				return -1;
			else if (bu.role == User.MODERATOR)
				return 1;
			else if (au.raiseHand && bu.raiseHand) {
				// do nothing go to the end and check names
			} else if (au.raiseHand)
				return -1;
			else if (bu.raiseHand)
				return 1;
			else if (au.phoneUser && bu.phoneUser) {
				
			} else if (au.phoneUser)
				return -1;
			else if (bu.phoneUser)
				return 1;
			
			/* 
			* Check name (case-insensitive) in the event of a tie up above. If the name 
			* is the same then use userID which should be unique making the order the same 
			* across all clients.
			*/
			if (au.name.toLowerCase() < bu.name.toLowerCase())
				return -1;
			else if (au.name.toLowerCase() > bu.name.toLowerCase())
				return 1;
			else if (au.userID.toLowerCase() > bu.userID.toLowerCase())
				return -1;
			else if (au.userID.toLowerCase() < bu.userID.toLowerCase())
				return 1;
			
			return 0;
		}
		
		public function addUser(newuser:User):void {
			trace("Adding new user [" + newuser.userID + "]");
			if (! hasUser(newuser.userID)) {
				trace("Am I this new user [" + newuser.userID + ", " + _me.userID + "]");
				if (newuser.userID == _me.userID) {
					newuser.me = true;
				}						
				
				_users.addItem(newuser);
				_users.refresh();
				
				userJoinedSignal.dispatch(newuser);
			}					
		}
		
		public function hasUser(userID:String):Boolean {
			var p:Object = getUserIndex(userID);
			if (p != null) {
				return true;
			}
			
			return false;		
		}
		
		public function getUser(userID:String):User {
			var p:Object = getUserIndex(userID);
			if (p != null) {
				return p.participant as User;
			}
			
			return null;				
		}
		
		public function removeUser(userID:String):void {
			var p:Object = getUserIndex(userID);
			if (p != null) {
				// Flag that the user is leaving the meeting so that apps (such as avatar) doesn't hang
				// around when the user already left.
				p.participant.isLeavingFlag = true;
				
				trace("removing user[" + p.participant.name + "," + p.participant.userID + "]");				
				_users.removeItemAt(p.index);
				_users.refresh();
				
				userLeftSignal.dispatch(p.participant);
			}							
		}
		
		public function getPresenter():User {
			var u:User;
			for (var i:int = 0; i < _users.length; i++) {
				u = _users.getItemAt(i) as User;				
				if (u.presenter)
					return u;
			}
			return null;
		}
		
		public function removePresenter(userID:String):void {
			var u:User = getPresenter();
			if (u.presenter) {
				u.presenter = false;
				//Signal that the presenter has been removed
				
				if (u.me)
					_me.presenter = false;
			}
		}
		
		public function assignPresenter(userID:String):void {
			var u:Object = getUserIndex(userID);
			if (u) {
				u.participant.presenter = true;
				
				//Signal that there is a new presenter
				
				if (u.participant.me)
					_me.presenter = true;
			}
		}
		
		public function userStreamChange(userID:String, hasStream:Boolean, streamName:String):void {
			var p:Object = getUserIndex(userID);
			
			if (p) {
				p.participant.hasStream = hasStream;
				p.participant.streamName = streamName;
				
				if (p.participant.me)
					_me.hasStream = hasStream;
				
				userChangeSignal.dispatch(p.participant, "hasStream");
			}
		}
		
		public function raiseHandChange(userID:String, value:Boolean):void {
			var p:Object = getUserIndex(userID);
			
			if (p) {
				p.participant.raiseHand = value;
				
				// Signal for raise hand change
				
				if (p.participant.me)
					_me.raiseHand = value;
			}
		}
		
		/**
		 * Get the index number of the participant with the specific userid 
		 * @param userid
		 * @return -1 if participant not found
		 * 
		 */		
		private function getUserIndex(userID:String):Object {
			var aUser:User;
			
			for (var i:int = 0; i < _users.length; i++) {
				aUser = _users.getItemAt(i) as User;
				
				if (aUser.userID == userID) {
					return {index:i, participant:aUser};
				}
			}				
			
			// Participant not found.
			return null;
		}
	}
}