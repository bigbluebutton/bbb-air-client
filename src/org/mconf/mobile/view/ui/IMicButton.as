package org.mconf.mobile.view.ui
{
	import org.mconf.mobile.core.view.IView;
	import org.osflash.signals.ISignal;

	public interface IMicButton extends IView
	{
		function get turnOnMicSignal(): ISignal;
		function get turnOffMicSignal(): ISignal;
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		
	}
}