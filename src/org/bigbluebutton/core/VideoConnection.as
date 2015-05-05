package org.bigbluebutton.core {
	
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
	
	public class VideoConnection extends DefaultConnectionCallback implements IVideoConnection {
		
		[Inject]
		public var baseConnection:IBaseConnection;
		
		private var _ns:NetStream;
		
		private var _cameraPosition:String;
		
		protected var _successConnected:ISignal = new Signal();
		
		protected var _unsuccessConnected:ISignal = new Signal();
		
		protected var _applicationURI:String;
		
		private var _camera:Camera;
		
		private var _selectedCameraQuality:int;
		
		public static var CAMERA_QUALITY_LOW:int = 0;
		
		public static var CAMERA_QUALITY_MEDIUM:int = 1;
		
		public static var CAMERA_QUALITY_HIGH:int = 2;
		
		public function VideoConnection() {
			Log.getLogger("org.bigbluebutton").info(String(this));
		}
		
		[PostConstruct]
		public function init():void {
			baseConnection.init(this);
			baseConnection.successConnected.add(onConnectionSuccess);
			baseConnection.unsuccessConnected.add(onConnectionUnsuccess);
		}
		
		private function onConnectionUnsuccess(reason:String):void {
			unsuccessConnected.dispatch(reason);
		}
		
		private function onConnectionSuccess():void {
			_ns = new NetStream(baseConnection.connection);
			successConnected.dispatch();
		}
		
		public function get unsuccessConnected():ISignal {
			return _unsuccessConnected;
		}
		
		public function get successConnected():ISignal {
			return _successConnected;
		}
		
		public function set uri(uri:String):void {
			_applicationURI = uri;
		}
		
		public function get uri():String {
			return _applicationURI;
		}
		
		public function get connection():NetConnection {
			return baseConnection.connection;
		}
		
		public function connect():void {
			baseConnection.connect(uri);
		}
		
		public function get cameraPosition():String {
			return _cameraPosition;
		}
		
		public function set cameraPosition(position:String):void {
			_cameraPosition = position;
		}
		
		public function get camera():Camera {
			return _camera;
		}
		
		public function set camera(value:Camera):void {
			_camera = value;
		}
		
		public function get selectedCameraQuality():int {
			return _selectedCameraQuality;
		}
		
		public function set selectedCameraQuality(value:int):void {
			_selectedCameraQuality = value;
		}
		
		/**
		 * Set video quality based on the user selection
		 **/
		public function selectCameraQuality(value:int):void {
			switch (value) {
				case CAMERA_QUALITY_LOW:
					camera.setMode(160, 120, 10);
					camera.setQuality(camera.bandwidth, 50);
					selectedCameraQuality = CAMERA_QUALITY_LOW;
					break;
				case CAMERA_QUALITY_MEDIUM:
					camera.setMode(320, 240, 10);
					camera.setQuality(camera.bandwidth, 50);
					selectedCameraQuality = CAMERA_QUALITY_MEDIUM;
					break;
				case CAMERA_QUALITY_HIGH:
					camera.setMode(640, 480, 10);
					camera.setQuality(camera.bandwidth, 75);
					selectedCameraQuality = CAMERA_QUALITY_HIGH;
					break;
				default:
					camera.setMode(320, 240, 10);
					camera.setQuality(camera.bandwidth, 50);
					selectedCameraQuality = CAMERA_QUALITY_MEDIUM;
					break;
			}
		}
		
		public function startPublishing(camera:Camera, streamName:String):void {
			_ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_ns.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
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
				_ns = new NetStream(baseConnection.connection);
			}
		}
	}
}
