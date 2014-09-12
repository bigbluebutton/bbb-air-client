package org.bigbluebutton.view.navigation.pages.pollslist
{

	import spark.components.List;
	
	public class PollsListView extends PollsListViewBase implements IPollsListView
	{	
		public function get list():List {
			return pollsList;
		}
		
		override protected function childrenCreated():void {
			super.childrenCreated();
		}

		public function dispose():void {
			
		}
		
	}
}