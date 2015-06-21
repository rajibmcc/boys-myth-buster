package com.bbc_icontent.screens
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.ScoreFeedback;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ScreenKitchenFeedback extends ScoreFeedback
	{
		private var _barRed:Sprite;
		private var _barGreen:Sprite;
		private var _bat:Sprite;
		
		public function ScreenKitchenFeedback()
		{
			super();
			_barRed = barRed as Sprite;
			_barGreen = barGreen as Sprite;
			_buttonSkip = bt_skip as Sprite;
			_bat = bat as Sprite;
			
			_txtFeedback = txtFeedback as TextField;
			_txtDescription = txtDescription as TextField;
		}
		
		override public function show():void{
			super.show();
			
			TweenLite.fromTo(_bat, 1,{y:-330}, {y:12, ease:Bounce.easeOut});
		}
		
		override public function set isCorrect(value:Boolean):void{
			super.isCorrect = value;
			_barGreen.visible = value;
			_barRed.visible =! value;
			
			if (value) 
			{
				_txtFeedback.text="PgrKvi! Zzwg wKQz wg_ ev÷vi c‡q›U †c‡qQ| Avi g‡b †i‡Lv...";
			}else{
				_txtFeedback.text="In‡nv, †Zvgvi DËi fzj n‡q‡Q Z‡e g‡b †i‡Lv...";
			}
			
			
			scoreMessage = "Ilya ev †Zj e¨envi K‡i cyi“lv‡½i AvKvi-AvK…wZ cwieZ©b Kiv hvqbv; G‡Z eis ¶wZ nIqvi m¤¢vebv _v‡K |cyi“lv½ wb‡q †Zvgvi AviI wKQz Rvbvi _vK‡j Wv³vi ev ¯^v¯’¨Kg©xi mv‡_ K_v ej‡e|";

		}
	}
}