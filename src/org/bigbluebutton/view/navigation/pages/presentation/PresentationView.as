package org.bigbluebutton.view.navigation.pages.presentation
{
	import flash.display.StageOrientation;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.system.LoaderContext;
	
	import mx.core.FlexGlobals;
	
	import org.bigbluebutton.model.presentation.Slide;
	
	import spark.components.Image;
	
	public class PresentationView extends PresentationViewBase implements IPresentationView
	{
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			rotationHandler(FlexGlobals.topLevelApplication.currentOrientation);
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
		
		override public function rotationHandler(rotation:String):void {
			switch (rotation) {
				case StageOrientation.ROTATED_LEFT:
					content.rotation = -90;
					break;
				case StageOrientation.ROTATED_RIGHT:
					content.rotation = 90;
					break;
				case StageOrientation.UPSIDE_DOWN:
					content.rotation = 180;
					break;
				case StageOrientation.DEFAULT:
				case StageOrientation.UNKNOWN:
				default:
					content.rotation = 0;
			}	
		}
			
		public function dispose():void
		{
			
		}

	}
}