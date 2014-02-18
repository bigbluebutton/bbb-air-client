package org.bigbluebutton.model.presentation
{
	import mx.collections.ArrayCollection;
	
	import org.bigbluebutton.model.ConferenceParameters;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.UserSession;

	public class PresentationList
	{
		[Inject]
		public var userSession:IUserSession;
		
		[Inject]
		public var conferenceParameters:IConferenceParameters;
		
		public var presentations:ArrayCollection = new ArrayCollection();
		private var _uri:String = null;
		
		public function PresentationList() {
		}
		
		public function addPresentation(presentationName:String):void {
			trace("Adding presentation " + presentationName);
			for (var i:int=0; i < presentations.length; i++) {
				var p:Presentation = presentations[i] as Presentation;
				if (p.fileName == presentationName) return;
			}
			presentations.addItem(new Presentation(presentationName));
		}
		
		public function removePresentation(presentationName:String):void {
			for (var i:int=0; i < presentations.length; i++) {
				var p:Presentation = presentations[i] as Presentation;
				if (p.fileName == presentationName) {
					trace("Removing presentation " + presentationName);
					presentations.removeItemAt(i);
				}
			}
		}
			
		public function loadPresentation(presentationName:String):void {
			/*
			if (_uri == null) _userSession.config.getConfigFor("PresentModule").@uri;
			
			trace("PresentProxy::loadPresentation: presentationName=" + presentationName);
			for (var i:int=0; i < presentations.length; i++) {
				var p:Presentation = presentations[i] as Presentation;
				if (p.fileName == presentationName) {
					var fullUri:String = _uri + "/presentation/" + conferenceParameters.conference + "/" + conferenceParameters.room + "/" + presentationName+"/slides";	
					var slideUri:String = _uri + "/presentation/" + conferenceParameters.conference + "/" + conferenceParameters.room + "/" + presentationName;
					
					trace("PresentationApplication::loadPresentation()... " + fullUri);
					p.load(fullUri, slideUri);
					trace('number of slides=' + p.slides.length);
					
					return;
				}
			}
			
			trace("loadPresentation failed: " + presentationName + " not found");
			*/
		}
	}
}