package org.bigbluebutton.view.ui
{
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	import mx.states.SetStyle;
	import mx.states.State;
	
	import spark.components.Button;
	
	public class MicButton extends Button implements IMicButton
	{
		public function MicButton()
		{
			super();
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			var selected:State = new State({name : "selected"});
			var unselected:State = new State({name : "unselected"});
			selected.overrides = [new SetStyle(this,"backgroundImage", this.getStyle('mutedBackgroundImage') )];
			this.states.push(selected);
			this.states.push(unselected);
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
			if(_selected){
				currentState = "selected";
			}
			else currentState = "unselected";
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
	}
}