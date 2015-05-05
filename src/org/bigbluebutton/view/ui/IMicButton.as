package org.bigbluebutton.view.ui {
	
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;
	
	public interface IMicButton extends IView {
		function setVisibility(val:Boolean):void;
		function get muted():Boolean;
		function set muted(value:Boolean):void;
	}
}
