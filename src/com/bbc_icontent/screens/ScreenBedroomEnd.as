package com.bbc_icontent.screens
{
	import com.bbc_icontent.EndScreen;
	import com.greensock.TweenLite;
	import com.mcc.interactives.SceneManager;
	import com.mcc.interactives.IEvents.SceneEvents;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScreenBedroomEnd extends EndScreen
	{
		private var _movBegining:MovieClip;
		private var _movEnding:Sprite;
		private var _buttonNext:Sprite;
		private var _sceneMan:SceneManager;
		public function ScreenBedroomEnd()
		{
			super();
			_movBegining = clipStart as MovieClip;
			_movEnding = clipEnd as Sprite;
			_movEnding.visible = false;
			_buttonNext = bt_next as Sprite;
			_buttonNext.visible = false;
			
			_movBegining.stop();			
			_sceneMan = new SceneManager(_movBegining);
		}
		
		override public function show():void{
			_sceneMan.play();
			_sceneMan.addEventListener(SceneEvents.PLAY_ALL_COMPLETE, showButton);
			super.show();
		}
		
		private function showButton(e:SceneEvents):void{
			_buttonNext.visible = true;
			_buttonNext.addEventListener(MouseEvent.CLICK, showEndSeq);
		}
		
		private function showEndSeq(e:MouseEvent):void{
			_buttonNext.visible = false;
			_buttonNext.removeEventListener(MouseEvent.CLICK, showEndSeq);
			_movBegining.visible = false;
			_movEnding.visible = true;
			TweenLite.fromTo(_movEnding, 1, {x:-1280}, {x:0});
			DelayCall.call(watiUserProceedNext, 1.5);
		}
		
		private function watiUserProceedNext():void{
			_buttonNext.visible = true;
			_buttonNext.addEventListener(MouseEvent.CLICK, prepareExit);
		}
		
		private function prepareExit(e:MouseEvent):void{
			_buttonNext.removeEventListener(MouseEvent.CLICK, prepareExit);
			finished();
		}
	}
}