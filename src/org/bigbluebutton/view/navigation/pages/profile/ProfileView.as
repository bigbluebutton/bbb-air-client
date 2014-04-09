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

		public function get cameraOnOffText():Label
		{
			return cameraOnOffTxt0;
		}
		
		public function get shareMicButton():Button
		{
			return shareMicBtn0;
		}
		
		public function get micOnOffText():Label
		{
			return micOnOffTxt0;
		}
		
		public function get raiseHandText():Label
		{
			return raiseHandLabel0;
		}
		
		public function get raiseHandButton():Button
		{
			return raiseHandButton0;
		}
		
		public function get cameraQualityRadioGroup():RadioButtonGroup
		{
			return cameraQualityTypeRadioButtonGroup;
		}
		
		public function setCameraQualityGroupVisibility(hasStream:Boolean):void
		{
			cameraQualityGroup.visible = hasStream;
			cameraQualityGroup.includeInLayout = hasStream;
		}	
	}
}