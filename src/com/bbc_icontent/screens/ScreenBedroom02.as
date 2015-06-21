package com.bbc_icontent.screens
{
	import com.bbc_icontent.InfoGame;
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.objects.ClockSkined;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	public class ScreenBedroom02 extends Screen
	{
		
		private var sec:int = 60;
		private var quizTime:ClockSkined;
		
		private var vut:MovieClip;
		private var dragActive:Boolean;
		private var dragCurrent:MovieClip;
		private var dragOffsetX:Number;
		private var dragOffsetY:Number;
		
		private var rightW:MovieClip,wrongW:MovieClip,QC:MovieClip;
		private var dataArr:Array;
		private var scoreCount:int = 0,answerCount = 0;
		
		private var vutPositionX:Number,vutPositionY:Number;
		private var vutPositionInitX:Number,vutPositionInitY:Number;
		
		private var rightTag:String = "r";
		private var wrongTag:String = "w";
		private var currentTag:String;		
		private var currentQMsg:String;		
		
		
		
		
		private var textLine:TextLine;
		
		public function ScreenBedroom02()
		{
			// constructor code
			scoreMax = 5;
			
			quizTime = clock as ClockSkined;
			quizTime.setup(sec);
			quizTime.visible = false;
			
			vut = clipVut as MovieClip;
			vut.visible = false;
			vut.scaleX = 0.1;
			vut.scaleY = 0.1;
			vutPositionInitX = vut.x;
			vutPositionInitY = vut.y;
			
			vutPositionX = vut.x;
			vutPositionY = 200;
			
			rightW = rightWindow as MovieClip;
			wrongW = wrongWindow as MovieClip;
			
			dataArr=new Array();
			dataArr.push(wrongTag+"40 †dvuUv i³ †_‡K GK †dvuUv exh© ˆZwi nq|", 
				rightTag+"ïµvby I †mwgbvj d¬yBW bvgK GK ai‡bi Zi‡ji wgkª‡Y exh© ˆZwi nq|",  
				rightTag+"KviI KviI A‡bK †ewk, Avevi KviI KviI Zzjbvg~jK Kg ¯^cœ‡`vl nq|",
				wrongTag+"†Q‡j‡`i ¯^cœ‡`vl n‡j Zv Zv‡`i `ye©j evwb‡q †`q|",
				rightTag+"¯^cœ‡`vl LyeB ¯^vfvweK GKwU welq| GwU †Kv‡bv †ivM bq|");
			
			QC = QCntainer as MovieClip;
			QC.visible = false;
			
			textLine = text_line as TextLine;
		}
		
		override public function show():void
		{
			//level start point
			/*quizTime.visible = true;
			quizTime.addEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			quizTime.start();*/
			textLine.appear();
			textLine.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, startGame);
			textLine.addEventListener(TextLineEvents.TEXTLINE_END, startGame);
			//restartPartial();
			super.show();
		}
		
		private function callVut():void
		{
			if (answerCount>=5)
			{
				quizTime.stopClock();
				quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
				QC.visible = false;
				scoreValue = scoreCount;
				
				if (scoreCount>0)
				{
					this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_RIGHT_MOVE));
				}
				else
				{
					this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_WRONG_MOVE));
				}
				
				trace("SCORE :::::::::::::::::"+ scoreCount);
				
				return;
			}
			
			QC.visible = false;
			vut.x = vutPositionInitX;
			vut.y = vutPositionInitY;
			vut.visible = true;
			TweenLite.to(vut, 2, {x:vutPositionX, y:vutPositionY, scaleX:1, scaleY:1, ease:Elastic.easeOut, onComplete:animateLinesComplete, onCompleteParams:[vut]});
		}
		
		private function animateLinesComplete(mc:MovieClip):void
		{
			//pop question
			QuestionSetUp();
			
			//add listener
			enableDraging(mc);
		}
		
		private function QuestionSetUp()
		{
			this.setChildIndex(QC, (this.numChildren-1));
			var st:String = dataArr[answerCount];
			currentTag = st.substr(0,1);
			QC.txt.text = st.substr(1,st.length);
			QC.visible = true;
			
			scoreMessage= InfoGame.getScoreFeedbackMsg("score_feedback_bedroom_0"+(answerCount+1) );
		}
		
		
		private function enableDraging(mc:MovieClip):void
		{
			dragActive = false;
			mc.addEventListener(MouseEvent.MOUSE_DOWN, stickWithPointer);
		}
		
		private function stickWithPointer(e: MouseEvent):void
		{
			trace('MOUSE DOWN happend');
			if (! dragActive)
			{
				dragCurrent = e.currentTarget as MovieClip;
				addChild(dragCurrent);
				
				dragCurrent.removeEventListener(MouseEvent.MOUSE_DOWN, stickWithPointer);
				dragActive = true;
				dragOffsetX = dragCurrent.x - stage.mouseX;
				dragOffsetY = dragCurrent.y - stage.mouseY;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, dragOverStage);
				stage.addEventListener(MouseEvent.MOUSE_UP, dragCompleted);
			}
			else
			{
				return;
			}
		}
		
		private function dragOverStage(e: MouseEvent):void
		{
			dragCurrent.x = dragOffsetX + stage.mouseX;
			dragCurrent.y = dragOffsetY + stage.mouseY;
			//checkCollision(dragCurrent);
			trace("dragging...");
		}
		
		private function dragCompleted(e: MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragOverStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, dragCompleted);
			
			trace("drag complete...");
			
			if (rightW.hitTestPoint(dragCurrent.x,dragCurrent.y,true))
			{
				trace("right...");
				answerCount++;
				if (currentTag == rightTag)
				{
					scoreCount++;
					TweenLite.to(vut, .5, {x:rightW.x, y:rightW.y,  rotation:-360,  scaleX:0, scaleY:0,  onComplete:checkAnswerRight });
				}else{
					TweenLite.to(vut, .5, {x:rightW.x, y:rightW.y,  rotation:-360,  scaleX:0, scaleY:0,  onComplete:checkAnswerWrong });
				}
				
				
				
			}
			else if (wrongW.hitTestPoint(dragCurrent.x, dragCurrent.y, true))
			{
				trace("wrong...");
				answerCount++;
				if (currentTag == wrongTag)
				{
					scoreCount++;
					TweenLite.to(vut, .5, {x:wrongW.x, y:wrongW.y, rotation:-360, scaleX:0, scaleY:0,  onComplete:checkAnswerRight });
					
				}else{
					TweenLite.to(vut, .5, {x:wrongW.x, y:wrongW.y, rotation:-360, scaleX:0, scaleY:0,  onComplete:checkAnswerWrong });	
				}
				
			}
			else
			{
				trace('nothing...');
				dragActive = false;
				enableDraging(dragCurrent);
				TweenLite.to(vut, 1, {x:vutPositionX, y:vutPositionY, ease:Elastic.easeOut,  onComplete:changeQCDisplayIndex});
			}
		}
		
		private function checkAnswerRight(){
			pause();
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_RIGHT_MOVE));
		}
		
		private function checkAnswerWrong(){
			pause();
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_WRONG_MOVE));
		}
		
		private function changeQCDisplayIndex():void
		{
			this.setChildIndex(QC, (this.numChildren-1));
		}
		
		private function startGame(e:TextLineEvents):void
		{
			if(e.type == TextLineEvents.TEXTLINE_END){
				textLine.disAppear();
				return;
			}
			
			quizTime.visible = true;
			quizTime.addEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			quizTime.start();
			
			callVut();
		}
		
		
		override public function hide():void
		{
			trace('Hiding ins screen.......');
			quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			quizTime.stopClock();
			super.hide();
		}
		
		override public function destroy():void
		{
			quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			quizTime.destroy();
			
			super.destroy();
		}
		
		override public function pause():void{
			quizTime.stopClock();
		}
		
		override public function resume():void{
			quizTime.start();
			if(answerCount == 5){
				//Game over all question done.
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
			}
			else{
				callVut();
			}
		}
		
		override public function restartPartial():void
		{
			callVut();
			
			quizTime.visible = true;
			
			quizTime.restart();
			quizTime.addEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
		}
		
		function timesUp(e: TimerEvent):void
		{
			scoreValue = 0;
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_TIMEUP));
		}
	}
	
}