package com.bbc_icontent.screens
{
	import com.bbc_icontent.events.LevelEvents;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ScreenGameStart extends Sprite
	{
		private var _buttonStart:Sprite;
		private var _buttonClose:Sprite;
		public function ScreenGameStart()
		{
			super();
			_buttonStart = null;
			_buttonClose = null;
			
			trace(getChildByName("buttonStart")+'hello buttons'+getChildByName("buttonClose"));
			
			if(getChildByName("buttonStart") != null) {
				_buttonStart = getChildByName("buttonStart") as Sprite;
				_buttonStart.addEventListener(MouseEvent.CLICK, buttonTriggered);
			}
			if(getChildByName("buttonClose") != null) {
				_buttonClose = getChildByName("buttonClose") as Sprite;
				_buttonClose.addEventListener(MouseEvent.CLICK, buttonTriggered);
			}
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onRemoved(e:Event):void{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
			if(_buttonStart != null) _buttonStart.removeEventListener(MouseEvent.CLICK, buttonTriggered);
			if(_buttonClose != null) _buttonClose.removeEventListener(MouseEvent.CLICK, buttonTriggered);
		}
		
		private function buttonTriggered(e:MouseEvent):void{
			switch(e.currentTarget)
			{
				case _buttonStart:
				{
					this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_START));
					break;
				}
				case _buttonClose:
				{
					this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_SKIP));
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
	}
}