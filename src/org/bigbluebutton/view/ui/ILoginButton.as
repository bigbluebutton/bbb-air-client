package org.bigbluebutton.view.ui {
	
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;
	
	public interface ILoginButton extends IView {
		function get loginSignal():ISignal;
	}
}
