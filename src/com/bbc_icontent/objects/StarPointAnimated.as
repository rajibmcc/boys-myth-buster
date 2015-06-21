package com.bbc_icontent.objects
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class StarPointAnimated extends Sprite
	{
		private var _gravity:Number;
		private var _vx:Number;
		private var _vy:Number;
		private var _force:Number;
		public function StarPointAnimated()
		{
			super();
		}
		
		public function fly():void{
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void{
			
		}
	}
}