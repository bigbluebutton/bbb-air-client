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

	public interface IListenersServiceSO
	{
		function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void
		function disconnect():void
		function get muteStateSignal():ISignal
		function muteUnmuteUser(userId:Number, mute:Boolean):void
		/**
		 * Callback from the server from many of the bellow nc.call methods
		 */
	}
}