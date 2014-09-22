package org.bigbluebutton.core
{
	import flash.media.Camera;
	import flash.net.NetConnection;
	
	import org.osflash.signals.ISignal;
	
	public interface IVideoConnection
	{
		function get unsuccessConnected():ISignal
		function get successConnected():ISignal
		function get unsuccessIOSConnected():ISignal
		function get successIOSConnected():ISignal
		function get successIOSVideoReconnected():ISignal
		function set uri(uri:String):void
		function get uri():String
		function set iosUri(uri:String):void
		function get iosUri():String
		function get connection():NetConnection
		function get iosConnection():NetConnection
		function get iosBaseConnection():IBaseConnection
		function get cameraPosition():String;
		function set cameraPosition(position:String):void
		function get camera():Camera;
		function set camera(value:Camera):void
		function get selectedCameraQuality():int;
		function set selectedCameraQuality(value:int):void
		function get streamViewCounter():int
		function increaseStreamViewCounter():void
		function resetStreamViewCounter():void
		function connect():void 
		function connectIOS():void 
		function startPublishing(camera:Camera, streamName:String):void
		function stopPublishing():void
		function selectCameraQuality(value:int):void
	}
}