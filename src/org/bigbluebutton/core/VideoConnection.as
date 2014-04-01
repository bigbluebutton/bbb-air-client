package org.bigbluebutton.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Camera;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import mx.utils.ObjectUtil;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;

	public class VideoConnection extends DefaultConnectionCallback implements IVideoConnection
	{
		private var _ns:NetStream;
		private var _cameraPosition:String;
		
		protected var _successConnected:ISignal = new Signal();
		protected var _unsuccessConnected:ISignal = new Signal();
		
		protected var _baseConnection:BaseConnection;
		protected var _applicationURI:String;
		
		public function VideoConnection()
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			_baseConnection = new BaseConnection(this);
			_baseConnection.successConnected.add(onConnectionSuccess);
			_baseConnection.unsuccessConnected.add(onConnectionUnsuccess);
		}
		
		private function onConnectionUnsuccess(reason:String):void
		{
			unsuccessConnected.dispatch(reason);
		}
		
		private function onConnectionSuccess():void
		{
			_ns = new NetStream(_baseConnection.connection);
			successConnected.dispatch();
		}
		
		public function get unsuccessConnected():ISignal
		{
			return _unsuccessConnected;
		}
		
		public function get successConnected():ISignal
		{
			return _successConnected;
		}
		
		public function set uri(uri:String):void {
			_applicationURI = uri;
		}
		
		public function get uri():String {
			return _applicationURI;
		}
		
		public function get connection():NetConnection {
			return _baseConnection.connection;
		}
		
		public function connect():void {
			_baseConnection.connect(uri);
		}
		
		public function get cameraPosition():String
		{
			return _cameraPosition;
		}
		
		public function set cameraPosition(position:String):void
		{
			_cameraPosition = position;
		}
		
		public function startPublishing(camera:Camera, streamName:String):void {
			_ns.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			_ns.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_ns.addEventListener( AsyncErrorEvent.ASYNC_ERROR, onAsyncError );
			_ns.client = this;
			_ns.attachCamera(camera);
			_ns.publish(streamName);
		}
		
		private function onNetStatus(e:NetStatusEvent):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":onNetStatus() " + e.info.code);
		}
		
		private function onIOError(e:IOErrorEvent):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":onIOError() " + e.toString());
		}
		
		private function onAsyncError(e:AsyncErrorEvent):void {
			Log.getLogger("org.bigbluebutton").info(String(this) + ":onAsyncError() " + e.toString());
		}
		
		public function stopPublishing():void {
			if (_ns != null) {
				_ns.attachCamera(null);
				_ns.close();
				_ns = null;
				_ns = new NetStream(_baseConnection.connection);
			}
		}
	}
}