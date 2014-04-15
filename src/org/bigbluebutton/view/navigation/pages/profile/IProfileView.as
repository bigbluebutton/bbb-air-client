package org.bigbluebutton.view.navigation.pages.profile
{
	import org.bigbluebutton.core.view.IView;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.RadioButtonGroup;

	public interface IProfileView extends IView
	{
		function get userNameText():Label;
		function get shareCameraButton():Button;
		function get cameraOnOffText():Label
		function get shareMicButton():Button;
		function get micOnOffText():Label
		function get raiseHandText():Label;
		function get raiseHandButton():Button;
		function get cameraQualityRadioGroup():RadioButtonGroup;
		function setCameraQualityGroupVisibility(hasStream:Boolean):void
	}
}