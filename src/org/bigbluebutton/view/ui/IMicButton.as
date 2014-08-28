package org.bigbluebutton.view.ui
{
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;

	public interface IMicButton extends IView
	{
		function setVisibility(val:Boolean):void;
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function set enabled(value:Boolean):void;
	}
}