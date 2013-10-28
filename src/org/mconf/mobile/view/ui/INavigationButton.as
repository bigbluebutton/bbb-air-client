package org.mconf.mobile.view.ui
{
	import mx.core.IUIComponent;
	
	import org.mconf.mobile.core.view.IView;
	import org.osflash.signals.ISignal;

	public interface INavigationButton extends IView
	{
		function get navigationSignal(): ISignal
			
		function get navigateTo():String
		function set navigateTo(value:String):void
			
		function get action():String
		function set action(value:String):void
			
		function get currentState():String
		function set currentState(value:String):void
			
		function get states():Array
	}
}