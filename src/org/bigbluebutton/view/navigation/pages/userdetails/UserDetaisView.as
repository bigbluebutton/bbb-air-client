package org.bigbluebutton.view.navigation.pages.userdetails
{
	import flash.events.MouseEvent;
	
	import org.bigbluebutton.model.User;
	
	import spark.components.Button;
	
	public class UserDetaisView extends UserDetaisViewBase implements IUserDetaisView
	{
		public function UserDetaisView():void
		{
				
		}	
		
		
		
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
			if(user != null && mainshell != null)
			{
				userNameText.text = _user.name;
				statusText.text = _user.role;
				cameraIcon.visible = _user.hasStream;
				micIcon.visible = (_user.voiceJoined && !_user.muted);
				micOffIcon.visible = (_user.voiceJoined && _user.muted);
				soundIcon.visible = user.talking; 
				
				//TODO: buttons
				showCameraButton0.includeInLayout = _user.hasStream;
				showCameraButton0.visible = _user.hasStream;
				
				showPrivateChat0.includeInLayout = !_user.me;
				showPrivateChat0.visible = !_user.me;
			}
		}
		
		public function dispose():void
		{
			
		}

		public function get showCameraButton():Button
		{
			return showCameraButton0;
		}
		
		public function get showPrivateChat():Button
		{
			return showPrivateChat0;
		}
		
		
	}
}