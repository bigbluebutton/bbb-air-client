package org.bigbluebutton.view.ui
{
	import flash.events.MouseEvent;
	
	public class MicButton extends MicButtonBase implements IMicButton
	{
		public function MicButton()
		{
			super();
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
		}		
		
		public function dispose():void
		{
			
		}
		
		public function setVisibility(val:Boolean):void {
			this.visible = val;
		}
		
		protected var _selected:Boolean = false;
		
		public function set selected(b:Boolean):void
		{
			_selected = b;
			if(_selected) currentState = "selected";
			else currentState = "unselected";
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
	}
}