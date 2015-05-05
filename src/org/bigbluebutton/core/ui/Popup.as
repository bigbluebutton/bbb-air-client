package org.bigbluebutton.core.ui {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	import org.bigbluebutton.core.ui.api.IPopup;
	import org.bigbluebutton.core.view.IView;
	import robotlegs.bender.extensions.viewManager.api.IViewManager;
	import spark.components.Application;
	
	/**
	 * Wrapper class for the PopUpManager that
	 * improves the testability of the desig.n
	 */
	public class Popup implements IPopup {
		
		[Inject]
		public var viewManager:IViewManager;
		
		/**
		 * Presents the view as a popup.
		 */
		public function add(view:IView):void {
			viewManager.addContainer(view as DisplayObjectContainer);
			try {
				PopUpManager.addPopUp(view as UIComponent, FlexGlobals.topLevelApplication as DisplayObject, true);
				PopUpManager.centerPopUp(view as UIComponent);
			} catch (err:Error) {
			}
		}
		
		/**
		 * Removes view from being a popup.
		 */
		public function remove(view:IView):void {
			PopUpManager.removePopUp(view as UIComponent);
			viewManager.removeContainer(view as DisplayObjectContainer);
		}
	}
}
