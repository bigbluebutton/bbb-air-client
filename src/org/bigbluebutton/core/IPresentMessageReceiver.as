package org.bigbluebutton.core
{
	public interface IPresentMessageReceiver
	{
		function onMessage(messageName:String, message:Object):void
	}
}