package org.bigbluebutton.view.navigation.pages.presentation
{
	import flash.events.MouseEvent;
	import flash.system.LoaderContext;
	
	import org.bigbluebutton.model.presentation.Slide;
	
	public class PresentationView extends PresentationViewBase implements IPresentationView
	{
		
		//private var _buttonTestSignal: Signal = new Signal();
		//public function get buttonTestSignal(): ISignal
		//{
		//	return _buttonTestSignal;
		//}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
		}
		
		public function onClick(e:MouseEvent):void
		{
			//buttonTestSignal.dispatch();
		}

		public function setPresentationName(name:String):void {
			presentationName.text = name;
		}
		
		public function setSlide(s:Slide):void {
			if (s != null) {
				slide.source = s.data;
			} else {
				slide.source = null;
			}
		}
		
		public function dispose():void
		{
			
		}

	}
}