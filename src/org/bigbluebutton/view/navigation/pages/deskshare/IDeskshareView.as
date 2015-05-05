package org.bigbluebutton.view.navigation.pages.deskshare {
	
	import flash.net.NetConnection;
	import org.bigbluebutton.view.navigation.pages.common.MenuButtonsView;
	import spark.components.Group;
	import spark.components.Label;
	
	public interface IDeskshareView {
		function get deskshareGroup():Group;
		function stopStream():void;
		function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void;
		function get noDeskshareMessage():Label;
		function changeMouseLocation(x:Number, y:Number):void;
	}
}
