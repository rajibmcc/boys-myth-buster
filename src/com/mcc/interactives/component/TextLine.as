package com.mcc.interactives.component
{
	import com.mcc.interactives.IEvents.TextLineEvents;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Strong;
	
	public class TextLine extends MovieClip
	{
		private var button_skip:Sprite;
		private var button_next:Sprite;
		private var text_line:TextField;
		
		private var _syncPoints:Vector.<int>;
		
		private var tweenIN:Tween;
		private var tweenOut:Tween;
		
		public function TextLine()
		{
			super();
			stop();
			visible = false;
			
			button_next = bt_next as Sprite;
			button_skip = bt_skip as Sprite;
			
			_syncPoints = new Vector.<int>();
		}
		
		public function set syncPoints(syncPointsArray:Array):void{
			for(var i:int = 0; i<syncPointsArray.length; i++){
				_syncPoints.push(syncPointsArray[i] as int);
			}
		}
		
		public function appear():void{
			visible = true;
			//alpha = 0;
			inAnim(this);
			
			button_next.addEventListener(MouseEvent.CLICK, buttonTriggred);
			button_skip.addEventListener(MouseEvent.CLICK, buttonTriggred);
		}
		
		public function disAppear():void{
			outAnim(this);
			button_next.removeEventListener(MouseEvent.CLICK, buttonTriggred);
			button_skip.removeEventListener(MouseEvent.CLICK, buttonTriggred);
		}
		
		private function buttonTriggred(e:MouseEvent):void{
			switch(e.currentTarget){
				case button_next:
					if(currentFrame != totalFrames){
						nextFrame();
						fireSyncEvent();
						text_line = findTextline();
						if(text_line != null) inAnim(text_line);
					}
					else{
						this.dispatchEvent(new TextLineEvents(TextLineEvents.TEXTLINE_END));
					}					
					break;
				case button_skip:
					this.dispatchEvent(new TextLineEvents(TextLineEvents.TEXTLINE_SKIP));
					break;
			}
			
			
		}
		
		private function fireSyncEvent():void{
			for(var i:int; i<_syncPoints.length; i++){
				if(currentFrame == _syncPoints[i]){
					this.dispatchEvent(new TextLineEvents(TextLineEvents.TEXTLINE_SYNC));
					return;
				}
			}
		}
		
		private function inAnim(dispObj:DisplayObject):void{
			tweenIN = new Tween(dispObj,"alpha", Strong.easeIn, 0, 1, .8, true);
			tweenIN.addEventListener(TweenEvent.MOTION_FINISH, inTweenDone);
		}
		private function outAnim(dispObj:DisplayObject):void{
			tweenOut = new Tween(dispObj,"alpha", Strong.easeIn, 1, 0, .8, true);
			tweenOut.addEventListener(TweenEvent.MOTION_FINISH, outTweenDone);
		}
		
		private function inTweenDone(e:TweenEvent):void{
			this.dispatchEvent(new TextLineEvents(TextLineEvents.TEXTLINE_APPEARED));
		}
		
		private function outTweenDone(e:TweenEvent):void{
			this.dispatchEvent(new TextLineEvents(TextLineEvents.TEXTLINE_DISAPPEARED));
		}
		
		private function findTextline():TextField{
			//trace('TOTAL CHILDREN : '+numChildren);
			for(var i:int = 0; i<numChildren; i++){
				//trace('FOUND'+ getChildAt(i));
				if(getChildAt(i) is TextField){
					return getChildAt(i) as TextField;
				}
			}
			
			return null;
		}
	}
}