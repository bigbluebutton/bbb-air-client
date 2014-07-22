package org.bigbluebutton.view.navigation.pages.takepoll
{
	import org.bigbluebutton.core.view.IView;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	
	public interface ITakePollView extends IView {
		function get questionViews():Group;
		function get submitButton():Button;
		function get errorMessage():Label;
	}
}
