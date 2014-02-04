package org.bigbluebutton.view.navigation.pages.profile
{
	import org.bigbluebutton.core.view.IView;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;

	public interface IProfileView extends IView
	{
		function get userNameText():Label;
		function get cameraButton():Button;
		function get cameraOnOFFText():Label
		function get cameraStatus():Group
	}
}