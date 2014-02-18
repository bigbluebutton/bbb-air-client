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
	}
}