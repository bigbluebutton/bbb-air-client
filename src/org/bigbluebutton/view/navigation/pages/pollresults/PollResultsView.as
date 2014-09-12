package org.bigbluebutton.view.navigation.pages.pollresults
{
	import spark.components.Group;

	public class PollResultsView extends PollResultsViewBase implements IPollResultsView
	{	
		public function get resultsList():Group {
			return resultsList0;
		}
		
		override protected function childrenCreated():void {
			super.childrenCreated();
		}
		
		public function dispose():void {
			
		}
	}
}