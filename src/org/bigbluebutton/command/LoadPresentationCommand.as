package org.bigbluebutton.command
{
	import org.bigbluebutton.model.ConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.presentation.Presentation;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class LoadPresentationCommand extends Command
	{
		[Inject]
		public var userSession: IUserSession
		
		[Inject]
		public var conferenceParameters: ConferenceParameters;
		
		[Inject]
		public var presentationName: String;
		
		override public function excecute():void {
			var p:Presentation = userSession.presentationList.getPresentation(presentationName);
			
			if (p != null) {
				var uri:String = userSession.config.getConfigFor("PresentModule").@uri;
				
				var fullUri:String = uri + "/presentation/" + conferenceParameters.conference + "/" + conferenceParameters.room + "/" + presentationName+"/slides";	
				var slideUri:String = uri + "/presentation/" + conferenceParameters.conference + "/" + conferenceParameters.room + "/" + presentationName;
				
				trace("PresentationApplication::loadPresentation()... " + fullUri);
				p.load(fullUri, slideUri);
				trace('number of slides=' + p.slides.length);
			} else {
				
			}
		}
		
		private function load(url:String, slideURI:String):void {
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
		
		private function parse(xml:XML):void {
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