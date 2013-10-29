package org.mconf.mobile.view.ui
{
	import org.mconf.mobile.core.view.IView;
	import org.osflash.signals.ISignal;

	public interface ILoginButton extends IView
	{
		function get loginSignal(): ISignal;
	}
}