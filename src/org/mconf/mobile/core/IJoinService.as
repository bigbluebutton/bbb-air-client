package org.mconf.mobile.core
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	
	import org.osflash.signals.ISignal;

	public interface IJoinService
	{
		function get successJoinedSignal():ISignal;
		function get unsuccessJoinedSignal():ISignal;
		function load(joinUrl:String):void;
	}
}