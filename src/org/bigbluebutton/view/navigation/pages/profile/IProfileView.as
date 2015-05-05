package org.bigbluebutton.view.navigation.pages.profile {
	
	import org.bigbluebutton.core.view.IView;
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.RadioButtonGroup;
	
	public interface IProfileView extends IView {
		function get userNameButton():Button;
		function get shareCameraButton():Button;
		function get shareCameraBtnLabel():String;
		function get shareMicButton():Button;
		function get shareMicBtnLabel():String;
		function get raiseHandBtnLabel():String;
		function get raiseHandButton():Button;
		function get logoutButton():Button;
	}
}
