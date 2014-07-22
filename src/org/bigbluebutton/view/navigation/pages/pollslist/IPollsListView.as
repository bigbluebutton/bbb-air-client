package org.bigbluebutton.view.navigation.pages.pollslist
{
	import org.bigbluebutton.core.view.IView;
	
	import spark.components.List;
	
	public interface IPollsListView extends IView
	{
		function get list():List;
	}
}
