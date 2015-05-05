package org.bigbluebutton.view.ui {
	
	import mx.core.IUIComponent;
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;
	
	public interface INavigationButton extends IView {
		function get navigationSignal():ISignal
		function get transitionAnimation():int
		function set transitionAnimation(value:int):void
		function get navigateTo():Array
		function set navigateTo(value:Array):void
		function get pageDetails():String
		function set pageDetails(value:String):void
		function get currentState():String
		function set currentState(value:String):void
		function get states():Array
	}
}
