package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;
	
	import spark.components.Label;

	public interface IVideoChatView extends IView
	{
		function stopStream():void
		function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void
		function get noVideoMessage():Label
		function getDisplayedUserID():String
	}
}