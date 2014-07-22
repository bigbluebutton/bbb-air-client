package org.bigbluebutton.view.navigation.pages.pollresults
{
	import org.bigbluebutton.core.view.IView;
	
	import spark.components.Group;
	
	public interface IPollResultsView extends IView
	{
		function get resultsList():Group
	}
}
