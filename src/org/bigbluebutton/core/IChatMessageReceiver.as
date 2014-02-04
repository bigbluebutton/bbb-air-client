package org.bigbluebutton.core
{
	public interface IChatMessageReceiver
	{
		function onMessage(messageName:String, message:Object):void
	}
}