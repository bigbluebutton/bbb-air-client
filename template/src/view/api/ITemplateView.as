package org.mconf.mobile.template.view.api
{
	import org.mconf.mobile.core.view.IView;
	import org.osflash.signals.ISignal;

	public interface ITopView extends IView
	{
		function get actionSignal(): ISignal;
		
//		function get taskDescription(): String;
//		function set taskDescription(value: String): void;
	}
}