package org.mconf.mobile.model
{
	import mx.collections.ArrayCollection;
	
	import spark.collections.Sort;

	public class UserList
	{
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
				
				//TODO Send a signal saying that a user has been added
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
				trace("removing user[" + p.participant.name + "," + p.participant.userID + "]");				
				_users.removeItemAt(p.index);
				_users.refresh();
				
				//TODO Send a signal saying that a user has left
			}							
		}
		
		public function assignPresenter(userID:String):void {
			var u:User;
			for (var i:int = 0; i < _users.length; i++) {
				u = _users.getItemAt(i) as User;				
				if (u.presenter)
					u.presenter = false;
			}
			
			u = getUser(userID);
			if (u) {
				u.presenter = true;
				//Signal that the presenter has changed
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