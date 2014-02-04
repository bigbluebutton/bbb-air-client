package org.bigbluebutton.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.model.ConnectionFailedEvent;
	import org.bigbluebutton.model.IMessageListener;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;
	
	public class DefaultConnectionCallback implements IDefaultConnectionCallback
	{
		public static const NAME:String = "DefaultConnectionCallback";
		
		private var _messageListeners:Array = new Array();

		public function onBWCheck(... rest):Number {
			return 0; 
		} 
		
		public function onBWDone(... rest):void { 
			trace("onBWDone() " + ObjectUtil.toString(rest));
			var p_bw:Number; 
			if (rest.length > 0) p_bw = rest[0]; 
			// your application should do something here 
			// when the bandwidth check is complete 
			trace("bandwidth = " + p_bw + " Kbps."); 
		}
		
		public function onMessageFromServer(messageName:String, result:Object):void {
			trace("Got message from server [" + messageName + "]");    
			notifyListeners(messageName, result);
		}		

		public function addMessageListener(listener:IMessageListener):void {
			_messageListeners.push(listener);
		}
		
		public function removeMessageListener(listener:IMessageListener):void {
			for (var ob:int=0; ob<_messageListeners.length; ob++) {
				if (_messageListeners[ob] == listener) {
					_messageListeners.splice (ob,1);
					break;
				}
			}
		}
		
		private function notifyListeners(messageName:String, message:Object):void {
			if (messageName != null && messageName != "") {
				for (var notify:String in _messageListeners) {
					_messageListeners[notify].onMessage(messageName, message);
				}                
			} else {
				trace("Message name is undefined");
			}
		}   
	}
}
