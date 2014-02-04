package org.bigbluebutton.view.ui
{
	import flash.events.MouseEvent;
	
	import org.bigbluebutton.model.User;
	
	public class MicStatus extends MicStatusBase implements IMicStatus
	{
		public function MicStatus()
		{
			super();
		}
		
		public function dispose():void
		{

		}
		
		protected var _user:User;
		
		public function set user(u:User):void
		{
			_user = u;
		}
				
		public function get user():User
		{
			return _user;
		}
		
		protected var _micEnabled:Boolean = false;
		
		public function set micEnabled(b:Boolean):void
		{
			_micEnabled = b;
			micIcon.visible = b;
			micOffIcon.visible = !b;
		}
		
		public function get micEnabled():Boolean
		{
			return _micEnabled;
		}


	}
}