package org.bigbluebutton.model.presentation
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;

	public class Presentation
	{
		private var _fileName:String = "";
		private var _slides:Vector.<Slide> = new Vector.<Slide>();
		private var _selected:int = -1;
		
		private var _slideURI:String;
		private var _urlLoader:URLLoader;
		
		public function Presentation(fileName:String):void {
			_fileName = fileName;
		}
		
		public function get fileName():String {
			return _fileName;
		}
		
		public function get slides():Vector.<Slide> {
			return _slides;
		}
		
		public function get selected():int {
			return _selected;
		}
		
		public function set selected(num:int):void {
			_selected = num;
		}
		
		public function getSlideAt(num:int):Slide {
			if (_slides.length > num) {
				return _slides[num];
			}
			trace("getSlideAt failed: Slide index out of bounds");
			return null;
		}
		
		public function add(slide:Slide):void {
			_slides.push(slide);
		}
		
		public function size():uint {
			return _slides.length;
		}
		
		private function clear():void {
			_slides = new Vector.<Slide>();
		}
		
		public function load(url:String, slideURI:String):void {
			_slideURI = slideURI;
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
			_urlLoader.load(new URLRequest(url));
		}
		
		private function loadCompleteHandler(e:Event):void {
			trace("Loading of " + _fileName + " complete");
			parse(new XML(e.target.data));
		}
		
		private function loadErrorHandler(e:IOErrorEvent):void {
			trace("Loading of " + _fileName + " failed: " + e.toString());
		}
		
		public function parse(xml:XML):void {
			var list:XMLList = xml.presentation.slides.slide;
			var item:XML;
			trace("Parsing slides: " + xml);
			
			var presentationName:String = xml.presentation[0].@name;
			trace("PresentationService::parse()...  presentationName=" + presentationName);
			
			// Make sure we start with a clean set.
			clear();
			
			for each(item in list){		
				var sUri:String = _slideURI + "/" + item.@name;
				var thumbURI:String =  _slideURI + "/" + item.@thumb;
				var textURI:String = _slideURI + "/" + item.@textfile;
				
				var slide:Slide = new Slide(item.@number, sUri, thumbURI, textURI);						
				add(slide);
				//LogUtil.debug("Available slide: " + sUri + " number = " + item.@number);
				//LogUtil.debug("Available thumb: " + thumbUri);
				trace("Available textfile: " + textURI);
			}		
			
			if (_slides.length > 0) {
				trace("The presentation has loaded: " + _fileName);
			} else {
				trace("The presentation failed to load: " + _fileName);
			}
		}
	}
}