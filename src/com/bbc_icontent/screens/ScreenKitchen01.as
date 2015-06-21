package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScreenKitchen01 extends Screen
	{
		private var _mov01:MovieClip;
		private var _buttonNext:Sprite;
		public function ScreenKitchen01()
		{
			super();
			
			_mov01 = batFlying as MovieClip;
			_mov01.stop();
			
			_buttonNext = bt_next as Sprite;
			_buttonNext.visible = false;
		}
		
		override public function show():void{
			_mov01.gotoAndPlay(1);
			AfterPlayClip.callBack(_mov01, prepareNextLevel);
		}
		
		private function prepareNextLevel():void{
			_buttonNext.visible = true;
			_buttonNext.addEventListener(MouseEvent.CLICK, exitLevel);
		}
		
		private function exitLevel(e:MouseEvent):void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
	}
}