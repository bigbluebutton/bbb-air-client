package org.bigbluebutton.view.navigation
{
	import flash.events.MouseEvent;
	
	import spark.transitions.ViewTransitionBase;
	
	public class PagesNavigatorView extends PagesNavigatorViewBase implements IPagesNavigatorView
	{
		protected var _joinURL:String

		public function get joinURL():String
		{
			return _joinURL;
		}

		public function set joinURL(value:String):void
		{
			_joinURL = value;
		}
				
		override protected function childrenCreated():void
		{
			super.childrenCreated();
		}
		
		public function onClick(e:MouseEvent):void
		{

		}

		public function dispose():void
		{
			
		}
	}
}