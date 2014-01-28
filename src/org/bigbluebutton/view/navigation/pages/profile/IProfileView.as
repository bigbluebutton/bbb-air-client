package org.bigbluebutton.view.navigation.pages.profile
{
	import org.bigbluebutton.core.view.IView;
	
	import spark.components.Label;

	public interface IProfileView extends IView
	{
		function get userNameText():Label;
	}
}