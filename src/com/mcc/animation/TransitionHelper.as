package com.mcc.animation
{
	import flash.display.DisplayObject;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;

	public class TransitionHelper
	{
		public static function fadeIn(target:DisplayObject, duration:Number = .8)
		{
			new Tween(target,"alpha", Strong.easeIn, 0, 1, duration, true);
		}
		
		public static function fadeOut(target:DisplayObject, duration:Number = .8){
			new Tween(target,"alpha", Strong.easeIn, 1, 0, duration, true);
		}
	}
}