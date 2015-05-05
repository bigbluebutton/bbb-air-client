package org.bigbluebutton.model.chat {
	
	public class UserVO {
		public var username:String;
		
		public var userid:String;
		
		public function UserVO(username:String, userid:String) {
			this.userid = userid;
			this.username = username;
		}
	}
}
