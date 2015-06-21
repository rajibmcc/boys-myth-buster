package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.AfterPlayClip;
	
	import flash.display.MovieClip;
	
	public class ScreenDownStair01 extends Screen
	{
		private var _textLine:TextLine;
		private var _mov01:MovieClip;
		public function ScreenDownStair01()
		{
			super();
			_mov01 = almira as MovieClip;
			_mov01.stop();
			_textLine = textline as TextLine;
			_textLine.syncPoints = [2];
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			_textLine.appear();
			_textLine.addEventListener(TextLineEvents.TEXTLINE_SYNC, onsync);
			_textLine.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, nextScene);
			_textLine.addEventListener(TextLineEvents.TEXTLINE_END, nextScene);
		}
		
		private function onsync(e:TextLineEvents):void{
			_mov01.gotoAndPlay(1);
			AfterPlayClip.callBack(_mov01);
		}
		
		private function nextScene(e:TextLineEvents):void{
			if(e.type == TextLineEvents.TEXTLINE_END) {
				_textLine.disAppear();
				return;
			}
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}
	}
}