package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.greensock.TweenMax;
	import com.mcc.animation.TransitionHelper;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScreenHome extends Screen
	{
		private var textLine:TextLine;
		private var button_start:Sprite;
		
		private var bgFar:Sprite;
		private var bgNear:Sprite;
		private var window:Sprite;
		
		public function ScreenHome()
		{
			super();
			button_start = bt_start as Sprite;
			textLine = text_line as TextLine;
			
			bgFar = far as Sprite;
			bgNear = near as Sprite;
			window = far.windowClose as Sprite;
		}
		
		override public function show():void{
			super.show();
			button_start.addEventListener(MouseEvent.CLICK, starButtonEventHandler);
		}
		
		override public function hide():void{
			textLine.addEventListener(TextLineEvents.TEXTLINE_SKIP, prepareLevel);
			textLine.addEventListener(TextLineEvents.TEXTLINE_END, prepareLevel);
		}
		
		override public function destroy():void{
			textLine.addEventListener(TextLineEvents.TEXTLINE_SKIP, prepareLevel);
			textLine.addEventListener(TextLineEvents.TEXTLINE_END, prepareLevel);
		}
		
		private function starButtonEventHandler(e:MouseEvent):void{
			//button_start.visible = false;
			TransitionHelper.fadeOut(button_start, .3);
			button_start.removeEventListener(MouseEvent.CLICK, starButtonEventHandler);
			
			textLine.appear();
			textLine.addEventListener(TextLineEvents.TEXTLINE_SKIP, prepareLevel);
			textLine.addEventListener(TextLineEvents.TEXTLINE_END, prepareLevel);
		}
		
		private function prepareLevel(e:TextLineEvents):void{
			//Fly some bats near window
			textLine.disAppear();
			textLine.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, runStartAnims);
		}
		
		private function runStartAnims(e:TextLineEvents):void{
			//window.visible = false;
			TransitionHelper.fadeOut(window, .3);
			DelayCall.call(homeScreenDone, 1);
		}
		
		private function homeScreenDone():void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_START));
		}
		
		private function starRoll():void{
			//var tweenNear:TweenMax = new TweenMax(bgNear, .5,{x: 527, y: 452, scaleX:1.54, scaleY:1.54});
			//var tweenFar:TweenMax =  new TweenMax(bgFar, 1,{x: 224, y: 588, scaleX:1.66, scaleY:1.66});
			
			//tweenNear.play();
			//tweenFar.play();
		}
	}
}