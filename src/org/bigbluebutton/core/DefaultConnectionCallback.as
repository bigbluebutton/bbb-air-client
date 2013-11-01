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
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;
	
	public class DefaultConnectionCallback implements IDefaultConnectionCallback
	{
		public static const NAME:String = "DefaultConnectionCallback";
		
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
			trace("Got message from server [" + messageName + "]\n" + ObjectUtil.toString(result));    
		}
/*
		public function sendMessage(service:String, onSuccess:Function, onFailure:Function, message:Object=null):void {
			trace("SENDING [" + service + "]");
			var responder:Responder =	new Responder(                    
				function(result:Object):void { // On successful result
					onSuccess("Successfully sent [" + service + "]."); 
				},	                   
				function(status:Object):void { // status - On error occurred
					var errorReason:String = "Failed to send [" + service + "]:\n"; 
					for (var x:Object in status) { 
						errorReason += "\t" + x + " : " + status[x]; 
					} 
				}
			);
			
			if (message == null) {
				_netConnection.call(service, responder);
			} else {
				_netConnection.call(service, responder, message);
			}
		}
*/
	}
}
