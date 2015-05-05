package org.bigbluebutton.view.navigation {
	
	import flash.events.MouseEvent;
	import spark.components.ViewNavigator;
	import spark.transitions.ViewTransitionBase;
	
	public class PagesNavigatorView extends ViewNavigator implements IPagesNavigatorView {
		override protected function childrenCreated():void {
			super.childrenCreated();
		}
		
		public function onClick(e:MouseEvent):void {
		}
		
		public function dispose():void {
		}
	}
}
