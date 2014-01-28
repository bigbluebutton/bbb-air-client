package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	
	public class ProfileView extends ProfileViewBase implements IProfileView
	{
		override protected function childrenCreated():void
		{
			super.childrenCreated();
		}

		public function dispose():void
		{
			
		}
		
		public function get userNameText():Label
		{
			return userName;
		}

		public function get cameraButton():Button
		{
			return cameraButton0;
		}

		public function get cameraOnOFFText():Label
		{
			return cameraOnOFFText0;
		}
		
		public function get cameraStatus():Group
		{
			return cameraStatus0;
		}
	}
}