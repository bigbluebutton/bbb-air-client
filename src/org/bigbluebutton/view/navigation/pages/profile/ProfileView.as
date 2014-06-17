package org.bigbluebutton.view.navigation.pages.profile
{
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.RadioButtonGroup;
	
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
		
		public function get shareCameraButton():Button
		{
			return shareCameraBtn0;
		}
				
		public function get shareCameraBtnLabel():String
		{
			return shareCameraBtn0.label;
		}
		
		public function get shareMicButton():Button
		{
			return shareMicBtn0;
		}

		public function get shareMicBtnLabel():String
		{
			return shareMicBtn0.label;
		}
		
		public function get raiseHandBtnLabel():String
		{
			return raiseHandButton0.label;
		}
		
		public function get raiseHandButton():Button
		{
			return raiseHandButton0;
		}
		
		public function get cameraQualityRadioGroup():RadioButtonGroup
		{
			return cameraQualityTypeRadioButtonGroup;
		}
		
		public function setCameraQuality(value:int):void
		{
			switch(value)
			{
				case 0:
					cameraQualityTypeRadioButtonGroup.selectedValue = "low";
					break;
				case 1:
					cameraQualityTypeRadioButtonGroup.selectedValue = "medium";
					break;
				case 2:
					cameraQualityTypeRadioButtonGroup.selectedValue = "high";
					break;	
			}
			
		}
		
		public function setCameraQualityGroupVisibility(hasStream:Boolean):void
		{
			cameraQualityGroup.visible = hasStream;
			cameraQualityGroup.includeInLayout = hasStream;
		}
		
		public function get logoutButton():Button
		{
			return logoutButton0;
		}			
	}
}