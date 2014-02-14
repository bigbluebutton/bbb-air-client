package org.bigbluebutton.model.presentation
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	public class Slide
	{
		private var _loader:URLLoader;
		private var _loaded:Boolean = false;
		private var _slideUri:String;
		private var _slideHandler:Function;
		private var _slideNum:Number;
		private var _thumbUri:String;
		private var _txtUri:String;
		private var _txtLoader:URLLoader;
		private var _txtLoaded:Boolean = false;
		
		public function Slide(slideNum:Number, slideUri:String, thumbUri:String,txtUri:String) {
			_slideNum = slideNum;
			_slideUri = slideUri;
			_thumbUri = thumbUri;
			_txtUri = txtUri;
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, handleComplete);	
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			
			_txtLoader = new URLLoader();
			_txtLoader.addEventListener(Event.COMPLETE, handleTextComplete);	
			_txtLoader.dataFormat = URLLoaderDataFormat.TEXT;	
		}
		
		public function load(slideLoadedHandler:Function):void {
			if (_loaded && _txtLoaded) {
				slideLoadedHandler(_slideNum, _loader.data, _txtLoader.data);
			} else {
				_slideHandler = slideLoadedHandler;
				_loader.load(new URLRequest(_slideUri));
				_txtLoader.load(new URLRequest(_txtUri));
			}
		}
		
		private function handleComplete(e:Event):void {
			_loaded = true;
			if (_slideHandler != null && _txtLoaded) {
				_slideHandler(_slideNum, _loader.data, _txtLoader.data);
			}		
		}
		
		private function handleTextComplete(e:Event):void {
			_txtLoaded = true;
			if (_slideHandler != null && _loaded) {
				_slideHandler(_slideNum, _loader.data, _txtLoader.data);
			}		
		}
		
		public function get thumb():String {
			return _thumbUri;
		}
		
		public function get slideNumber():Number {
			return _slideNum;
		}
	}
}