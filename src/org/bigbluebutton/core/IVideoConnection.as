package org.bigbluebutton.core
{
	import flash.media.Camera;
	import flash.net.NetConnection;
	
	import org.osflash.signals.ISignal;

	public interface IVideoConnection
	{
		function get unsuccessConnected():ISignal
		function get successConnected():ISignal
		function set uri(uri:String):void
		function get uri():String
		function get connection():NetConnection
		function get cameraPosition():String;
		function set cameraPosition(position:String):void
		function connect():void 
		function startPublishing(camera:Camera, streamName:String):void
		function stopPublishing():void
	}
}