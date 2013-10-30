package org.mconf.mobile.core
{
	import org.mconf.mobile.model.ConferenceParameters;
	import org.mconf.mobile.model.IConferenceParameters;
	import org.osflash.signals.ISignal;

	public interface IUsersServiceSO
	{
		//function get successfullyJoinedMeetingSignal():ISignal;
		//function get unsuccessfullyJoinedMeetingSignal():ISignal;
		function connect(uri:String, params:IConferenceParameters):void;
		function disconnect():void;
		function join():void;
	}
}