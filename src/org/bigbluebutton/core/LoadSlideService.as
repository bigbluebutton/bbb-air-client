package org.bigbluebutton.core
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import org.bigbluebutton.model.presentation.Slide;

	public class LoadSlideService
	{
		private var _loader:URLLoader
		private var _slide:Slide;
		
		public function LoadSlideService(s:Slide) {
			trace("LoadSlideService: loading a new slide");
			_slide = s;
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, handleComplete);	
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			
			_loader.load(new URLRequest(s.slideURI));
		}
		
		private function handleComplete(e:Event):void {
			_slide.data = _loader.data;
			trace("LoadSlideService: loading of slide data finished successfully");
		}
	}
}