package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.model.ConferenceParameters;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;
	
	public class DeskshareConnection extends DefaultConnectionCallback implements IDeskshareConnection
	{
		[Inject]
		public var baseConnection:IBaseConnection;
		
		[Inject] 
		public var conferenceParameters:IConferenceParameters;
		
		private var _successConnected:ISignal = new Signal();
		private var _unsuccessConnected:ISignal = new Signal();
		private var _isStreamingSignal:ISignal = new Signal();
		private var _isStreaming:Boolean;
		private var _streamCheckedOnStartup:Boolean;
		private var _streamWidth:Number;
		private var _streamHeight:Number;
		private var _applicationURI:String;
			
		public function DeskshareConnection()
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
		}
		
		[PostConstruct]
		public function init():void
		{
			baseConnection.init(this);
			baseConnection.successConnected.add(onConnectionSuccess);
			baseConnection.unsuccessConnected.add(onConnectionUnsuccess);
		}
		
		public function onConnectionSuccess():void
		{
			_successConnected.dispatch();
		}
		
		public function onConnectionUnsuccess(reason:String):void
		{
			_unsuccessConnected.dispatch(reason);
		}
	
		public function get applicationURI():String
		{
			return _applicationURI;
		}
		
		public function set applicationURI(value:String):void
		{
			_applicationURI = value;
		}
		
		public function get streamWidth():Number
		{
			return _streamWidth;
		}
		
		public function set streamWidth(value:Number):void
		{
			_streamWidth = value;
		}
		
		public function get streamHeight():Number
		{
			return _streamHeight;
		}
		
		public function set streamHeight(value:Number):void
		{
			_streamHeight = value;
		}
		
		public function get connection():NetConnection
		{
			return baseConnection.connection;
		}
		
		public function connect():void
		{
			baseConnection.connect(applicationURI);
		}
		
		public function get isStreaming():Boolean
		{
			return _isStreaming;
		}
		
		public function set isStreaming(value:Boolean):void
		{
			 _isStreaming = value;
		}
		
		public function get isStreamingSignal():ISignal
		{
			return _isStreamingSignal;
		}
		
		public function get streamCheckedOnStartup():Boolean
		{
			return _streamCheckedOnStartup;
		}
		
		public function set streamCheckedOnStartup(value:Boolean):void
		{
			_streamCheckedOnStartup = value;
		}

		public function get unsuccessConnected():ISignal
		{
			return _unsuccessConnected;
		}
		
		public function get successConnected():ISignal
		{
			return _successConnected;
		}
	}
}