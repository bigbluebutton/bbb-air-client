package org.bigbluebutton.view.navigation.pages.disconnect
{
	import spark.components.Button;

	public interface IDisconnectPageView
	{
		function get currentState():String
		function set currentState(value:String):void	
		function get exitButton():Button
	}
}