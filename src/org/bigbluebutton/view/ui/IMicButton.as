package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;

	public interface IMicButton extends IView
	{
		function get turnOnMicSignal(): ISignal;
		function get turnOffMicSignal(): ISignal;
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		
	}
}