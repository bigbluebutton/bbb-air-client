package org.bigbluebutton.model {
	
	public interface IMessageListener {
		function onMessage(messageName:String, message:Object):void;
	}
}
