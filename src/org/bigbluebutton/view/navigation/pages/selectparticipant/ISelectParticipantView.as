package org.bigbluebutton.view.navigation.pages.selectparticipant {
	
	import org.bigbluebutton.core.view.IView;
	import spark.components.List;
	
	public interface ISelectParticipantView extends IView {
		function get list():List;
	}
}
