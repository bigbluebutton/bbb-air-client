package org.bigbluebutton.model
{
	import org.osflash.signals.ISignal;

	public interface IUserSettings
	{
		function get changedSignal(): ISignal
			
		function get microphoneEnabled():Boolean
		function set microphoneEnabled(value:Boolean):void
	}
}