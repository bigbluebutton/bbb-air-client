package org.bigbluebutton.core
{
	import org.osflash.signals.Signal;

	public interface IUsersMessageReceiver
	{
		function onMessage(messageName:String, message:Object):void;
	}
}