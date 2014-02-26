package org.bigbluebutton.view.navigation.pages.presentation
{
	import org.bigbluebutton.core.view.IView;
	import org.bigbluebutton.model.presentation.Slide;
	import org.osflash.signals.ISignal;

	public interface IPresentationView extends IView
	{
		function setSlide(s:Slide):void;
		function setPresentationName(name:String):void;
	}
}