package com.bbc_icontent.screens
{
	import com.bbc_icontent.objects.BoyWalk;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class ScreenRoomFloor extends Sprite
	{
		private var walkBoy:BoyWalk;
		public function ScreenRoomFloor()
		{
			super();
			
			walkBoy = boy_walk as BoyWalk;
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedStage);
		}
		
		private function onAddedStage(e:Event):void{
			stage.addEventListener(MouseEvent.CLICK, stepAhead);
		}
		
		private function stepAhead(e:MouseEvent):void{
			walkBoy.stepLeft();
		}
	}
}