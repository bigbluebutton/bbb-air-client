package org.bigbluebutton.core
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import mx.utils.ObjectUtil;
	
	import org.bigbluebutton.model.ConnectionFailedEvent;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.User;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public interface IListenersServiceSO
	{
		function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void
		function disconnect():void
		function muteUnmuteUser(userId:Number, mute:Boolean):void
		/**
		 * Callback from the server from many of the bellow nc.call methods
		 */
	}
}