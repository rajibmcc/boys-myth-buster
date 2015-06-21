package com.bbc_icontent.screens
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.ScoreFeedback;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenBedroomFeedback extends ScoreFeedback
	{
		private var _barRed:Sprite;
		private var _barGreen:Sprite;
		private var _ghost:Sprite;
		
		public function ScreenBedroomFeedback()
		{
			super();
			_barRed = barRed as Sprite;
			_barGreen = barGreen as Sprite;
			_buttonSkip = bt_skip as Sprite;
			_ghost = ghost as Sprite;
			
			_txtFeedback = txtFeedback as TextField;
			_txtDescription = txtDescription as TextField;
		}
		
		override public function show():void{
			super.show();
			
			TweenLite.fromTo(_ghost, 1,{y:-330}, {y:12, ease:Bounce.easeOut});
		}
		
		override public function set isCorrect(value:Boolean):void{
			super.isCorrect = value;
			_barGreen.visible = value;
			_barRed.visible =! value;
		}
	}
}