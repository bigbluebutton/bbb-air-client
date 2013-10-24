package org.mconf.mobile.view.ui
{
	import org.mconf.mobile.core.view.IView;
	import org.osflash.signals.ISignal;

	public interface INavigationButton extends IView
	{
		function get navigationSignal(): ISignal
			
		function get pageToNavigate():String
		function set pageToNavigate(value:String):void
			
		function get action():String
		function set action(value:String):void
	}
}