package com.bbc_icontent
{
	import com.bbc_icontent.events.LevelEvents;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class ScoreFeedback extends Screen
	{
		protected var _buttonSkip:Sprite;
		protected var _txtFeedback:TextField;
		protected var _txtDescription:TextField;
		
		public function ScoreFeedback()
		{
			super();
		}
		
		override public function show():void{
			super.show();
			
			_buttonSkip.addEventListener(MouseEvent.CLICK, buttonTriggered);
		}
		
		override public function hide():void{
			_buttonSkip.removeEventListener(MouseEvent.CLICK, buttonTriggered);
			super.hide();
		}
		
		private function buttonTriggered(e:MouseEvent):void{
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_SKIP));
		}
		
		public function set isCorrect(value:Boolean):void{
			if(value){
				_txtFeedback.text = ""+InfoGame.getScoreFeedbackMsg(InfoGame.SCORE_FEEDBACK_POINT);
			}
			else{
				_txtFeedback.text = ""+InfoGame.getScoreFeedbackMsg(InfoGame.SCORE_FEEDBACK_NO_POINT);
			}
		}
		
		override public function set scoreMessage(value:String):void{
			super.scoreMessage = value;
			_txtDescription.text = ""+value;
		}
	}
}