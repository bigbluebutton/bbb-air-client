package org.mconf.mobile.view.navigation.pages.participants
{
	import mx.collections.IList;
	
	import org.mconf.mobile.core.view.IView;
	import org.osflash.signals.ISignal;
	
	import spark.components.List;

	public interface IParticipantsView extends IView
	{
		function get list():List;
	}
}