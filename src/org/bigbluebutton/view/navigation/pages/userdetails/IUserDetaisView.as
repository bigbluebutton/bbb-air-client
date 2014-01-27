package org.bigbluebutton.view.navigation.pages.userdetails
{
	import org.bigbluebutton.core.view.IView;
	import org.bigbluebutton.model.User;
	
	import spark.components.Button;

	public interface IUserDetaisView extends IView
	{
		function set user(u:User):void
		function get user():User
		function update():void
		function get showCameraButton():Button
	}
}