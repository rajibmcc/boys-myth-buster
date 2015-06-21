package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.SceneManager;
	import com.mcc.interactives.IEvents.SceneEvents;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	
	import flash.display.MovieClip;
	
	public class ScreenStairs01 extends Screen
	{
		private var _textLine:TextLine;
		private var _mov01:MovieClip;
		private var _mov02:MovieClip;
		private var _mov03:MovieClip;
		private var _sceneMan:SceneManager;
		public function ScreenStairs01()
		{
			super();
			_textLine=textline as TextLine;
			_textLine.syncPoints = [2];
			_mov01 = mov01 as MovieClip;
			_mov02 = mov02 as MovieClip;
			_mov03 = mov03 as MovieClip;
			_sceneMan = new SceneManager(_mov01, _mov02, _mov03);
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			_sceneMan.play();
			_sceneMan.addEventListener(SceneEvents.PLAY_COMPLETE, showTextline);
			_sceneMan.addEventListener(SceneEvents.PLAY_ALL_COMPLETE, prepareNextLevel);
		}
		
		private function showTextline(e:SceneEvents):void{
			_sceneMan.removeEventListener(SceneEvents.PLAY_COMPLETE, showTextline);
			_textLine.appear();
			_textLine.addEventListener(TextLineEvents.TEXTLINE_SYNC, showNextMov);
			_textLine.addEventListener(TextLineEvents.TEXTLINE_END, showNextMov);
		}
		
		private function showNextMov(e:TextLineEvents):void{
			_sceneMan.nextScene();
		}
		
		private function prepareNextLevel(e:SceneEvents){
			this.dispatchEvent( new LevelEvents(LevelEvents.LEVEL_NEXT) );
		}
		
	}
}