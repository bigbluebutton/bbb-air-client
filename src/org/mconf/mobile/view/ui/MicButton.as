package org.mconf.mobile.view.ui
{
	import flash.events.MouseEvent;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class MicButton extends MicButtonBase implements IMicButton
	{
		private var _turnOnMicSignal: Signal = new Signal();
		
		/**
		 * Dispatched when the user wants to cancel the
		 * adding or modifying of a todo item.
		 */
		public function get turnOnMicSignal(): ISignal
		{
			return _turnOnMicSignal;
		}
		
		private var _turnOffMicSignal: Signal = new Signal();
		
		/**
		 * Dispatched when the user wants to save the
		 * description entered to the to do list.
		 */
		public function get turnOffMicSignal(): ISignal
		{
			return _turnOffMicSignal;
		}
		
		public function MicButton()
		{
			super();
		}
		
		override protected function childrenCreated():void
		{
			super.childrenCreated();
			
			this.addEventListener(MouseEvent.CLICK, change);
		}
		
		protected function change(e:MouseEvent):void
		{
			// TODO: add validation to know if mic is on or not
			if(this.selected)
			{
				turnOffMicSignal.dispatch();
			}
			else
			{
				turnOnMicSignal.dispatch();
			}
		}		
		
		public function dispose():void
		{
			_turnOnMicSignal.removeAll();
			_turnOffMicSignal.removeAll();
			
			this.removeEventListener(MouseEvent.CLICK, change);
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