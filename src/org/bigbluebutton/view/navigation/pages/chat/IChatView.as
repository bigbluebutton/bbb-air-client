package org.bigbluebutton.view.navigation.pages.chat {
	
	import org.bigbluebutton.core.view.IView;
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.TextInput;
	
	public interface IChatView extends IView {
		function get list():List;
		function get inputMessage():TextInput;
		function get sendButton():Button;
		function get pageName():Label;
	}
}
