package org.mconf.mobile.core.ui.api
{
	import flash.display.DisplayObject;
	
	import org.mconf.mobile.core.view.IView;
	
	public interface IPopup
	{
		function add(view: IView): void;
		function remove(view: IView): void;
	}
}