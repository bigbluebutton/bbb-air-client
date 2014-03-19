package org.bigbluebutton.view.navigation.pages.presentation
{
	import flash.display.DisplayObject;
	
	import org.bigbluebutton.command.LoadSlideSignal;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.presentation.Presentation;
	import org.bigbluebutton.model.presentation.Slide;
	import org.osmf.logging.Log;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class PresentationViewMediator extends Mediator
	{
		[Inject]
		public var view: IPresentationView;
		
		[Inject]
		public var userSession: IUserSession;
		
		[Inject]
		public var loadSlideSignal: LoadSlideSignal;
		
		private var _currentPresentation:Presentation;
		private var _currentSlideNum:int = -1;
		private var _currentSlide:Slide;
		
		override public function initialize():void
		{
			Log.getLogger("org.bigbluebutton").info(String(this));
			
			userSession.presentationList.presentationChangeSignal.add(presentationChangeHandler);
			userSession.presentationList.slideChangeSignal.add(slideChangeHandler);
			
			setPresentation(userSession.presentationList.currentPresentation);
			setCurrentSlideNum(userSession.presentationList.currentSlideNum);
		}
		
		private function displaySlide():void {
			if (_currentSlide != null) {
				_currentSlide.slideLoadedSignal.remove(slideLoadedHandler);
			}
			
			if (_currentPresentation != null && _currentSlideNum >= 0) {
				_currentSlide = _currentPresentation.getSlideAt(_currentSlideNum);
				if (_currentSlide != null) {
					if (_currentSlide.loaded && view != null) {
						view.setSlide(_currentSlide);
					} else {
						_currentSlide.slideLoadedSignal.add(slideLoadedHandler);
						loadSlideSignal.dispatch(_currentSlide);
					}
				}
			} else if (view != null) {
				view.setSlide(null);
			}
		}
		
		private function presentationChangeHandler():void {
			setPresentation(userSession.presentationList.currentPresentation);
		}
		
		private function slideChangeHandler():void {
			setCurrentSlideNum(userSession.presentationList.currentSlideNum);
		}
		
		private function setPresentation(p:Presentation):void {
			_currentPresentation = p;
			if (_currentPresentation != null) {
				view.setPresentationName(_currentPresentation.fileName);
			} else {
				view.setPresentationName("");
			}
		}
		
		private function setCurrentSlideNum(n:int):void {
			_currentSlideNum = userSession.presentationList.currentSlideNum;
			displaySlide();
		}
		
		private function slideLoadedHandler():void {
			displaySlide();
		}
		
		override public function destroy():void
		{
			userSession.presentationList.presentationChangeSignal.remove(presentationChangeHandler);
			userSession.presentationList.slideChangeSignal.remove(slideChangeHandler);
			
			super.destroy();
			
			view.dispose();
			view = null;
		}
	}
}