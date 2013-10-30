package org.mconf.mobile.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.utils.ObjectUtil;
	
	import org.mconf.mobile.model.ConnectionFailedEvent;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;
	
	public interface IDefaultConnectionCallback
	{
		function onBWCheck(... rest):Number
		function onBWDone(... rest):void 
		function onMessageFromServer(messageName:String, result:Object):void
		// function sendMessage(service:String, onSuccess:Function, onFailure:Function, message:Object=null):void
	}
}
