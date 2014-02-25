package org.bigbluebutton.core
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.bigbluebutton.model.presentation.Presentation;
	import org.bigbluebutton.model.presentation.Slide;

	public class LoadPresentationService
	{
		private var _urlLoader:URLLoader;
		private var _slideURI:String;
		private var _presentation:Presentation;
		
		public function LoadPresentationService()
		{
		}
		
		public function load(url:String, slideURI:String, presentation:Presentation):void {
			_slideURI = slideURI;
			_presentation = presentation;
			
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
			_urlLoader.load(new URLRequest(url));
		}
		
		private function loadCompleteHandler(e:Event):void {
			trace("Loading of " + _presentation.fileName + " complete");
			parse(new XML(e.target.data));
		}
		
		private function loadErrorHandler(e:IOErrorEvent):void {
			trace("Loading of " + _presentation.fileName + " failed: " + e.toString());
		}
		
		private function parse(xml:XML):void {
			var list:XMLList = xml.presentation.slides.slide;
			var item:XML;
			trace("Parsing slides: " + xml);
			
			var presentationName:String = xml.presentation[0].@name;
			trace("PresentationService::parse()...  presentationName=" + presentationName);
			
			// Make sure we start with a clean set.
			_presentation.clear();
			
			for each(item in list){		
				var sUri:String = _slideURI + "/" + item.@name;
				var thumbURI:String =  _slideURI + "/" + item.@thumb;
				var textURI:String = _slideURI + "/" + item.@textfile;
				
				var slide:Slide = new Slide(item.@number, sUri, thumbURI, textURI);						
				_presentation.add(slide);
				//LogUtil.debug("Available slide: " + sUri + " number = " + item.@number);
				//LogUtil.debug("Available thumb: " + thumbUri);
				trace("Available textfile: " + textURI);
			}		
			
			if (_presentation.size() > 0) {
				trace("The presentation has loaded: " + _presentation.fileName);
				_presentation.finishedLoading();
			} else {
				trace("The presentation failed to load: " + _presentation.fileName);
			}
		}
	}
}