package org.mconf.mobile.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import mx.utils.ObjectUtil;
	
	import org.mconf.mobile.model.ConnectionFailedEvent;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.mconf.mobile.model.IUserSession;
	import org.mconf.mobile.model.User;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class BaseServiceSO
	{
/*		
		protected var _successConnected:ISignal = new Signal();
		protected var _unsuccessConnected:ISignal = new Signal();
		protected var _disconnected:ISignal = new Signal();
*/
		
		private var _sharedObjectName:String;
		private var _sharedObject:SharedObject;
		private var _disconnectRequested:Boolean;
		
		public function BaseServiceSO(sharedObjectName:String) {
			_sharedObjectName = sharedObjectName;
		}
		
		public function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void {
			_disconnectRequested = false;
			_sharedObject = SharedObject.getRemote(_sharedObjectName, uri + "/" + params.room, false);
			_sharedObject.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusEvent);
			_sharedObject.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncErrorEvent);
			_sharedObject.client = this;
			_sharedObject.connect(connection);
		}
		
		public function disconnect():void {
			_disconnectRequested = true;
			if (_sharedObject != null) {
				_sharedObject.close();
			}
		}
		
		protected function onNetStatusEvent(e:NetStatusEvent):void {
			trace(ObjectUtil.toString(e));
			
			switch(e.info.code)
			{
				case "NetConnection.Connect.Success":
					break;
				
				case "NetConnection.Connect.Failed":
					sendConnectionFailedEvent(e.info.description);
					break;
				
				case "NetConnection.Connect.InvalidApp":	
					sendConnectionFailedEvent(e.info.description);
					break;
				
				case "NetConnection.Connect.AppShutDown":
					sendConnectionFailedEvent(e.info.description);
					break;
				
				case "NetConnection.Connect.Rejected":
					sendConnectionFailedEvent(e.info.description);
					break;
				
				case "NetConnection.Connect.Closed":
					sendDisconnectionEvent();
					break;
				
				default:
					break;
			}
		}
		
		protected function sendDisconnectionEvent():void
		{
//			disconnected.dispatch(_disconnectRequested);
		}
		
		protected function onAsyncErrorEvent(e:AsyncErrorEvent):void {
			trace(ObjectUtil.toString(e));
			sendConnectionFailedEvent(e.text);
		}
		
		protected function sendConnectionSuccessEvent():void {
//			successConnected.dispatch();
		}
		
		protected function sendConnectionFailedEvent(reason:String):void {
//			unsuccessConnected.dispatch(reason);
		}
/*
		public function get successConnected():ISignal
		{
			return _successConnected;
		}

		public function set successConnected(value:ISignal):void
		{
			_successConnected = value;
		}

		public function get unsuccessConnected():ISignal
		{
			return _unsuccessConnected;
		}

		public function set unsuccessConnected(value:ISignal):void
		{
			_unsuccessConnected = value;
		}

		public function get disconnected():ISignal
		{
			return _disconnected;
		}

		public function set disconnected(value:ISignal):void
		{
			_disconnected = value;
		}
*/

	}
}