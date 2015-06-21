package com.bbc_icontent.screens
{
	import com.bbc_icontent.EndScreen;
	import com.mcc.interactives.utils.AfterPlayClip;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScreenDownStairEnd extends EndScreen
	{
		private var _mov01:MovieClip;
		private var _mov02:MovieClip;
		
		private var _buttonNext:Sprite;
		public function ScreenDownStairEnd()
		{
			super();
			
			_mov01 = disapearSkull as MovieClip;
			_mov01.stop();
			_mov02 = clipStart as MovieClip;
			_mov02.stop();
			
			_buttonNext = bt_next as Sprite;
			_buttonNext.visible = false;
		}
		
		override public function show():void{
			_mov01.play();
			trace("---------------------------------- Wait END SCREEN -------------------------");
			AfterPlayClip.callBack(_mov01, prepareExit);
		}
		
		private function prepareExit():void{
			_mov02.play();
			AfterPlayClip.callBack(_mov02, showExitButton);
		}
		
		private function showExitButton():void{
			_buttonNext.visible = true;
			_buttonNext.addEventListener(MouseEvent.CLICK, fireExitEvent);
		}
		
		private function fireExitEvent(e:MouseEvent):void{
			_buttonNext.removeEventListener(MouseEvent.CLICK, fireExitEvent);
			finished();
		}
	}
}