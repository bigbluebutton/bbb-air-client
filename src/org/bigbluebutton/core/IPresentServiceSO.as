package org.bigbluebutton.core
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.model.IConferenceParameters;

	public interface IPresentServiceSO
	{
		function connect(connection:NetConnection, uri:String, params:IConferenceParameters):void
		function disconnect():void
		function sendCursorUpdate(xPercent:Number, yPercent:Number):void
		function move(xOffset:Number, yOffset:Number, widthRatio:Number, heightRatio:Number):void
		function removePresentation(name:String):void
		function getPresentationInfo():void
		function gotoSlide(num:int):void
		function getCurrentSlideNumber():void
		function sharePresentation(share:Boolean, presentationName:String):void
	}
}