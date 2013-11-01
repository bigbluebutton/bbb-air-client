package org.bigbluebutton.view.navigation.pages.videochat
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.core.view.IView;
	import org.osflash.signals.ISignal;

	public interface IVideoChatView extends IView
	{
		function cleanUpVideos():void
		function startStream(connection:NetConnection, name:String, streamName:String, userID:String, width:Number, height:Number):void
		function stopStream(userID:String):void
	}
}