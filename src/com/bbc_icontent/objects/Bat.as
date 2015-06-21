package com.bbc_icontent.objects
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	
	

	public class Bat extends MovieClip
	{
	
		TweenPlugin.activate([BezierPlugin]);
		
		
		
		private var myTimeout:uint;  
		private var startX:Number;  
		private var startY:Number;  
		private var boundsLeft:Number = 20;  
		private var boundsRight:Number = 940;  
		private var boundsTop:Number = 20;  
		private var boundsBottom:Number = 580;
		
		private var grivity:Number=3;
		private var speedy:int=0;
		
		private var speed:Number = 0;
		
		
		private var myRotation:Number = 0;
		private var ychange:Number;
		private var xchange:Number;

		private var dealyTimer:Timer;
		
		public var enableBuzz:Boolean;
		
		public var tweenLite:TweenLite;
		
		
		
		public function Bat()
		{
			startX = this.x;  
			startY = this.y;  
			
			//this.cacheAsBitmap = true;  
			
			addEventListener(Event.ADDED_TO_STAGE, attached);
			
			enableBuzz=true;
			
			buzzOff();  
			
			
		}
		
		
		public function attached ( e:Event ) : void  
		{  
			
			//trace("Hi I'm a Fly");  
			
		}  
		
		
		public function buzzOff () : void  
		{  
			if(enableBuzz){
				
			
			// Final position  
			var newX:int = getRandomX();  
			var newY:int = getRandomY();  
			
			
			// Bezier step points  
			var bx1:int = getRandomX();  
			var by1:int = getRandomY();  
			
			var bx2:int = getRandomX();  
			var by2:int = getRandomY();  
			
			var bx3:int = getRandomX();  
			var by3:int = getRandomY();
			
			tweenLite=new TweenLite(this,  2.5, {bezier:[{x:bx1, y:by1}, {x:bx2, y:by2}, {x:bx3, y:by3}, {x:newX, y:newY}], ease:Sine.easeInOut, onComplete:buzz});  
			
			}
		}  
		
		
		public function getRandomX () : int  
		{  
			
			return Math.round(boundsLeft + ((boundsRight - boundsLeft) * Math.random()));  
			
		}  
		
		public function getRandomY () : int  
		{  
			
			return Math.round(boundsTop + ((boundsBottom - boundsTop) * Math.random()));  
			
		}  
		
		
		public function buzz() : void  
		{  
			
			startX = this.x;  
			startY = this.y; 
			
			//this.addEventListener(Event.ENTER_FRAME, onBeeBuzingInpositon);
			buzzOff ();
			
			
			//this.gotoAndPlay(2);  
			
			//setTimeout(buzzOff, 10 + (Math.random() * 10));  
			dealyTimer=new Timer(1000, 1);
			dealyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			dealyTimer.start();
			
		}  
		
		
		private function onBeeBuzingInpositon(evt:Event):void
		{
			
			ychange =(Math.round(Math.random()*7-3));
			xchange = (Math.round(Math.random()*7-3));
			
			
				xchange*=-1;			
				ychange*=-1;
				
				x +=xchange;
				y +=ychange;		
				
			trace(xchange+"<>"+ychange);
			
		}
		
		protected function onTimerComplete(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			
			//this.removeEventListener(Event.ENTER_FRAME, onBeeBuzingInpositon);
			
			buzzOff ();
		}
		
		public function kill() : void  
		{  
			//this.addEventListener(Event.ENTER_FRAME, bee_fall);
			TweenLite.killTweensOf(this);
			
		}
		
		private function bee_fall(e:Event):void
		{
			// TODO Auto Generated method stub
			speedy=speedy+grivity;
			this.y+= speedy;
			
			if(this.y>=stage.stageHeight){
				this.removeEventListener(Event.ENTER_FRAME, bee_fall);
				
				
				if(dealyTimer!=null){
					dealyTimer.stop();	
				}
				
			}
			
		}
	}
}