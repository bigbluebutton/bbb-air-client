package org.bigbluebutton.view.navigation.pages.chatrooms {
	
	import org.bigbluebutton.core.view.IView;
	import spark.components.Button;
	import spark.components.List;
	import spark.components.TextInput;
	
	public interface IChatRoomsView extends IView {
		function get list():List;
	}
}
