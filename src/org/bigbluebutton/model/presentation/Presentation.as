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
		
		private var _changePresentation:Function;
		
		private var _loaded:Boolean = false;
		
		public function Presentation(fileName:String, changePresentation:Function):void {
			_fileName = fileName;
			_changePresentation = changePresentation;
		}
		
		public function get fileName():String {
			return _fileName;
		}
		
		public function get slides():Vector.<Slide> {
			return _slides;
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
		
		public function finishedLoading():void {
			_loaded = true;
			_changePresentation(this);
		}
		
		public function get loaded():Boolean {
			return _loaded;
		}
		
		public function clear():void {
			_slides = new Vector.<Slide>();
		}
	}
}