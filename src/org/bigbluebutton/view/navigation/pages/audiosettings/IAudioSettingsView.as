package org.bigbluebutton.view.navigation.pages.audiosettings {
	
	import org.bigbluebutton.core.view.IView;
	import spark.components.Button;
	
	public interface IAudioSettingsView extends IView {
		function get shareMicButton():Button;
		function get listenOnlyButton():Button;
	}
}
