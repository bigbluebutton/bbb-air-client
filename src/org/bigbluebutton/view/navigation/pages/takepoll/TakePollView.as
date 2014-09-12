package org.bigbluebutton.view.navigation.pages.takepoll
{
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	
	public class TakePollView extends TakePollViewBase implements ITakePollView
	{
		override protected function childrenCreated():void {
			super.childrenCreated();
		}
		
		public function get questionViews():Group {
			return questionViewGroup;
		}
		
		public function get submitButton():Button {
			return submitButton0;
		}
		
		public function get errorMessage():Label {
			return errorMessage0;
		}
		
		public function dispose():void {
			
		}
		
	}
}