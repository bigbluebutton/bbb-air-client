package org.bigbluebutton.model.presentation
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import flash.display.BitmapData;

	public class Slide
	{
		private var _loaded:Boolean = false;
		private var _slideURI:String;
		private var _slideNum:Number;
		private var _thumbURI:String;
		private var _txtURI:String;
		private var _data:ByteArray;
		private var _bitmap:BitmapData;
		
		private var _slideLoadedSignal:ISignal = new Signal;
		
		public function Slide(slideNum:Number, slideURI:String, thumbURI:String,txtURI:String) {
			_slideNum = slideNum;
			_slideURI = slideURI;
			_thumbURI = thumbURI;
			_txtURI = txtURI;
		}
		
		public function get thumb():String {
			return _thumbURI;
		}
		
		public function get slideNumber():Number {
			return _slideNum;
		}
		
		public function get data():ByteArray {
			return _data;
		}
		
		public function set data(d:ByteArray):void {
			_data = d;
			if (_data != null) {
				_loaded = true;
				slideLoadedSignal.dispatch();
			}
		}
		
		public function set bitmap(d:BitmapData):void {
			_bitmap = d;
			if (_bitmap != null) {
				_loaded = true;
				slideLoadedSignal.dispatch();
			}
		}
		
		public function get bitmap():BitmapData {
			return _bitmap;
		}
		
		public function get slideURI():String {
			return _slideURI;
		}
		
		public function get loaded():Boolean {
			return _loaded;
		}
		
		public function get slideLoadedSignal():ISignal {
			return _slideLoadedSignal;
		}
	}
}