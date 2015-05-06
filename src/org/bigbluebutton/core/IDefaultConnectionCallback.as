package org.bigbluebutton.core {
	
	import org.bigbluebutton.model.IMessageListener;
	
	public interface IDefaultConnectionCallback {
		function onBWCheck(... rest):Number
		function onBWDone(... rest):void
		function onMessageFromServer(messageName:String, result:Object):void
		function addMessageListener(listener:IMessageListener):void
		function removeMessageListener(listener:IMessageListener):void
	}
}
