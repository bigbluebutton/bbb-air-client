package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.core.view.IView;
	import org.bigbluebutton.model.User;

	public interface IMicStatus extends IView
	{
		function get micEnabled():Boolean;
		function set micEnabled(value:Boolean):void;
		function set user(u:User):void
		function get user():User
	}
}