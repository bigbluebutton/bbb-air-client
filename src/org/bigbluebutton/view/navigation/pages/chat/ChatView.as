package org.bigbluebutton.view.navigation.pages.chat
{
	import flash.events.MouseEvent;
	import flash.display.StageOrientation;
	import flash.events.StageOrientationEvent;
	import flash.system.LoaderContext;
	
	import mx.core.FlexGlobals;
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.TextInput;
	
	public class ChatView extends ChatViewBase implements IChatView
	{
		
		
		public function get list():List
		{
			return chatlist;
		}
		
		public function get inputMessage():TextInput
		{
			return inputMessage0;
		}
		
		public function get sendButton():Button
		{
			return sendButton0;
		}
		
		public function get pageTitle():Label
		{
			return pageTitle0;
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			rotationHandler(FlexGlobals.topLevelApplication.currentOrientation);
			//this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onClick(e:MouseEvent):void
		{
			//buttonTestSignal.dispatch();
		}

		public function dispose():void
		{
			
		}
		
//		override public function rotationHandler(rotation:String):void {
//			switch (rotation) {
//				case StageOrientation.ROTATED_LEFT:
//					_group.rotation = -90;
//					break;
//				case StageOrientation.ROTATED_RIGHT:
//					_group.rotation = 90;
//					break;
//				case StageOrientation.UPSIDE_DOWN:
//					_group.rotation = 180;
//					break;
//				case StageOrientation.DEFAULT:
//				case StageOrientation.UNKNOWN:
//				default:
//					_group.rotation = 0;
//			}	
//		}

	}
}