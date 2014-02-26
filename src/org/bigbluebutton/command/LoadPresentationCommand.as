package org.bigbluebutton.command
{
	import org.bigbluebutton.core.LoadPresentationService;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.presentation.Presentation;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class LoadPresentationCommand extends Command
	{
		[Inject]
		public var userSession: IUserSession
		
		[Inject]
		public var conferenceParameters: IConferenceParameters;
		
		[Inject]
		public var presentationName: String;
		
		private var _loadPresentationService:LoadPresentationService;
		
		override public function execute():void {
			var p:Presentation = userSession.presentationList.getPresentation(presentationName);
			
			if (p != null) {
				if (p.loaded) {
					trace("LoadPresentationCommand: presentation " + presentationName + " is already loaded");
					return;
				}
				
				var host:String = userSession.config.getConfigFor("PresentModule").@host;
				
				var fullUri:String = host + "/bigbluebutton/presentation/" + conferenceParameters.conference + "/" + conferenceParameters.room + "/" + presentationName+"/slides";	
				var slideUri:String = host + "/bigbluebutton/presentation/" + conferenceParameters.conference + "/" + conferenceParameters.room + "/" + presentationName;
				
				trace("LoadPresentationCommand::loadPresentation()... " + fullUri);
				_loadPresentationService = new LoadPresentationService();
				_loadPresentationService.load(fullUri, slideUri, p);
				trace('number of slides=' + p.slides.length);
			} else {
				trace("LoadPresentationCommand: failed to find presentation " + presentationName);
			}
		}
	}
}