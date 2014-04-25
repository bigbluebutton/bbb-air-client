package org.bigbluebutton.core
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.system.System;
	import flash.utils.ByteArray;
	
	import org.bigbluebutton.model.presentation.Slide;
	
	public class LoadSlideService
	{
		private var _loader:URLLoader
		private var _slide:Slide;
		
		public function LoadSlideService(s:Slide) {
			trace("LoadSlideService: loading a new slide");
			_slide = s;
			
			_loader = new URLLoader();
			
			_loader.addEventListener(Event.COMPLETE, handleURLLoaderComplete);	
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			
			_loader.load(new URLRequest(s.slideURI));
		}
		
		private function handleURLLoaderComplete(e:Event):void {
			var loader:Loader = new Loader();
			var context:LoaderContext = new LoaderContext();			
			context.allowCodeImport = true;
			context.applicationDomain = ApplicationDomain.currentDomain;
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaderComplete);	
			loader.loadBytes(_loader.data, context);
		}
		
		private function handleLoaderComplete(e:Event):void {
			var loaderInfo:LoaderInfo = LoaderInfo(e.target);
			var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, false, 0xFFFFFF);
			
			bitmapData.draw(loaderInfo.loader);
			_slide.bitmap = bitmapData;
			
			trace("LoadSlideService: loading of slide data finished successfully");
		}
	}
}