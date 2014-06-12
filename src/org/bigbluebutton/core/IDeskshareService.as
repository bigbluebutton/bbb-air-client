package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	import org.bigbluebutton.model.IConferenceParameters;

	public interface IDeskshareService
	{
		function checkIfStreamIsPublishing(room: String):void
		function connectDeskshareSO():void
	}
}