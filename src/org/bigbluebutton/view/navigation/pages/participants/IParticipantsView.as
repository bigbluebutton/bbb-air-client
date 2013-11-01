package org.bigbluebutton.view.navigation.pages.participants
{
	import mx.collections.IList;
	
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;
	
	import spark.components.List;

	public interface IParticipantsView extends IView
	{
		function get list():List;
	}
}