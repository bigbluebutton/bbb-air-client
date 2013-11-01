package org.bigbluebutton.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;

	public class VideoConnection extends DefaultConnectionCallback implements IVideoConnection
	{
		private var _ns:NetStream;
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
	}
}