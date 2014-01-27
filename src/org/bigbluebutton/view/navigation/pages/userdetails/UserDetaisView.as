package org.bigbluebutton.view.navigation.pages.userdetails
{
	import flash.events.MouseEvent;
	
	import org.bigbluebutton.model.User;
	
	public class UserDetaisView extends UserDetaisViewBase implements IUserDetaisView
	{
		
		protected var _user:User;
		
		public function set user(u:User):void
		{
			_user = u;
			update();
		}
		
		public function get user():User
		{
			return _user;
		}
		
		public function update():void
		{
			userNameText.text = _user.name;
			statusText.text = _user.role;
			cameraIcon.visible = _user.hasStream;
			micIcon.visible = (_user.voiceJoined && !_user.muted);
			micOffIcon.visible = (_user.voiceJoined && _user.muted);
			soundIcon.visible = user.talking; 
			
			//TODO: buttons
			
		}
		
		public function dispose():void
		{
			
		}

	}
}