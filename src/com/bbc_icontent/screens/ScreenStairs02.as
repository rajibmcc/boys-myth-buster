package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.custom_elements.Connector;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.objects.ClockSkined;
	import com.greensock.TweenLite;
	import com.greensock.easing.BounceInOut;
	import com.greensock.easing.Ease;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	public class ScreenStairs02 extends Screen{
		
		private var sec: int = 60;
		private var quizTime:ClockSkined;
		
		private var cl1:MovieClip,cl2:MovieClip,cl3:MovieClip,cl4:MovieClip,cl5:MovieClip,
					cr1:MovieClip,cr2:MovieClip,cr3:MovieClip,cr4:MovieClip,cr5:MovieClip;

		private var matchables:Vector.<MovieClip > ;
		private var matchDone:Vector.<MovieClip > ;
		private var matchablesLeft:Vector.<MovieClip > ;
		private var matchablesRight:Vector.<MovieClip > ;

		private var line:Connector;
		private var lines:Vector.<Connector > ;

		private var startPoint:Point,endPoint:Point;
		private var startClip:MovieClip,endClip:MovieClip;

		private var dataArr:Array=new Array();
		private var separetor:String = "/";
		
		private var screenStart:ScreenGameStart;
		
		private var screenDummy:Sprite;

		public function ScreenStairs02() {
			// constructor code			
			scoreMax=5;

			quizTime = clock as ClockSkined;
			quizTime.setup(sec);			
			quizTime.visible = false;
			
			screenStart = startScreen as ScreenGameStart;
			screenDummy = dummy as Sprite;
			screenDummy.visible = false;
			//left side
			cl1 = l1 as MovieClip;
			cl2 = l2 as MovieClip;
			cl3 = l3 as MovieClip;
			cl4 = l4 as MovieClip;
			cl5 = l5 as MovieClip;
			matchablesLeft=new Vector.<MovieClip>();
			matchablesLeft.push(cl1, cl2, cl3, cl4, cl5);

			//right side
			cr1 = r1 as MovieClip;
			cr2 = r2 as MovieClip;
			cr3 = r3 as MovieClip;
			cr4 = r4 as MovieClip;
			cr5 = r5 as MovieClip;
			matchablesRight=new Vector.<MovieClip>();
			matchablesRight.push(cr1, cr2, cr3, cr4, cr5);
			
			//data array
			dataArr.push("_y_yi g‡Zv exh©I Avgv‡`i kix‡i"+separetor+"mvivRxeb a‡i ˆZwi n‡Z _v‡K| ",
				" ¯^cœ‡`vl n‡jv"+separetor+"†Q‡j‡`i eqtmwÜ‡Z †cŠuQv‡bvi j¶Y¸‡jvi GKwU|", 
				"†Kv‡bv †Q‡ji ¯^cœ‡`vl nIqv gv‡b"+separetor+"Zvi cÖRbb Zš¿ ¯^vfvweKfv‡e MwVZ n‡”Q Ges ïµvby ˆZwi Ki‡Q|", 						
				" †Kv‡bv †Q‡ji ¯^cœ‡`vl bv n‡jI"+separetor+"GwU g‡b Kivi †Kv‡bv KviY †bB †h Zvi wj½ DwÌZ ev D‡ËwRZ n‡ebv|",						 
				" ¯^cœ‡`v‡li ci "+separetor+"†Zvgvi cyiælv½ I Gi Avkcv‡ki RvqMv fv‡jvfv‡e cwi®‹vi Ki‡Z n‡e|");

						 
			matchables=new Vector.<MovieClip>();
			matchables = matchablesLeft.concat(matchablesRight);
			//hide all matching parts
			showHideMatching(matchables, false);

			matchDone=new Vector.<MovieClip>();
			lines=new Vector.<Connector>();
			
			generateMessage();
		}
		
		private function generateMessage():void{
			var msgGenerated:String = '';
			
			for(var i:int = 0; i<dataArr.length; i++){
				var st:String = dataArr[i];
				var partLeft:String = st.substr(0, st.indexOf(separetor));
				var partRight:String = st.substr(st.indexOf(separetor) + 1, st.length);
				trace(i+" ANY "+partLeft);
				msgGenerated += (i+1)+". "+partLeft+" "+partRight+"\n";
			}
			
			scoreMessage = msgGenerated;
			trace(scoreMessage);
		}
		
		private function addMatchingListener():void
		{
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		private function removeMatchingListener():void
		{
			
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		override public function show(): void {
			//level start point
			
			screenStart.visible = true;
			addChild(screenStart);
			screenStart.addEventListener(LevelEvents.LEVEL_START, prepareInteractive);
		}
		
		private function prepareInteractive(e:LevelEvents):void{
			removeChild(screenStart);
			screenStart.addEventListener(LevelEvents.LEVEL_START, prepareInteractive);
			
			quizTime.visible = true;
			quizTime.addEventListener(TimerEvent.TIMER_COMPLETE, timesUp);	
			quizTime.start();
			
			prepareMatching(dataArr, matchablesLeft, matchablesRight );
			restartPartial();
		}
		
		
		private function startGame(): void {
			quizTime.visible = true;
			quizTime.addEventListener(TimerEvent.TIMER_COMPLETE, timesUp);			
			quizTime.start();
		}
		
		
		override public function hide():void
		{
			trace('Hiding ins screen.......');
			quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			quizTime.stopClock();
			super.hide();
		}
		
		override public function destroy():void{
			quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			quizTime.destroy();
			
			super.destroy();
		}
		
		override public function restartPartial():void
		{
			matchables=new Vector.<MovieClip>();
			matchables = matchablesLeft.concat(matchablesRight);
			
			
			for(var j in matchables){
				matchables[j].alpha=1;
			}
			
			for(var i in lines){
				removeChild(lines[i]);
			}
			
			lines = new Vector.<Connector>();
			
			//adding matching listener
			addMatchingListener();
				
			//hide all matching parts
			showHideMatching(matchables, true);
			quizTime.visible=true;			
			
			quizTime.restart();
			quizTime.addEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
		}

		function timesUp(e: TimerEvent):void
		{
			scoreValue = 0;
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_TIMEUP));
		}

		private function prepareMatching(_data:Array, cntLeft:Vector.<MovieClip>, cntRight:Vector.<MovieClip>):void
		{
			for (var i=0; i<_data.length; i++)
			{
				var st:String = _data[i];
				var partLeft:String = st.substr(0,st.indexOf(separetor));
				var partRight:String = st.substr(st.indexOf(separetor) + 1,st.length);

				cntLeft[i].txt.text = partLeft;
				cntRight[i].txt.text = partRight;
			}

			_random(cntLeft, cntRight);
			//_random(cntRight);
		}
		
		override public function resume():void
		{
			// TODO Auto Generated method stub
			super.resume();
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
			/*screenDummy.alpha = 0;
			addChild(screenDummy);
			TweenLite.to(screenDummy, .4, {alpha:1 onComplete:showDummyThenExit});*/
		}
		
		private function showDummyThenExit():void{
			trace("ALL IS DONE GOODBYE");
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_COMPLETE));
		}
		
		
		private function _random( cntLeft:Vector.<MovieClip>, cntRight:Vector.<MovieClip>)
		{
			for (var i=0; i<cntLeft.length; i++)
			{
				var randomPos:int = Math.random() * cntLeft.length;
				var txt:String = cntLeft[i].txt.text;
				cntLeft[i].txt.text = cntLeft[randomPos].txt.text;
				cntLeft[randomPos].txt.text = txt;
				
				//change right prt according to left
				 txt = cntRight[i].txt.text;
				cntRight[i].txt.text = cntRight[randomPos].txt.text;
				cntRight[randomPos].txt.text = txt;
				
			}
		}
		
		private function showHideMatching(cnt:Vector.<MovieClip>, visibility:Boolean):void{
			for (var i=0; i<cnt.length; i++)
			{				
				cnt[i].visible=visibility;				
			}
		}



		private function resultCheck()
		{
			quizTime.stopClock();
			quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			
			var totalMatchFound:int = 0;
			for (var j:int=0; j<lines.length; j++)
			{
				var cntr:Connector = lines[j] as Connector;
				var retivedSentace:String = cntr.startClip.txt.text + separetor + cntr.endClip.txt.text;

				for (var k:int=0; k<dataArr.length; k++)
				{
					if (retivedSentace==dataArr[k])
					{

						totalMatchFound++;
						break;
					}
				}

			}
			
			removeMatchingListener();

			if (totalMatchFound == 0)
			{
				
				trace("FAILED "+ totalMatchFound);
				this.scoreValue = 0
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_WRONG_MOVE));
			}
			else
			{				
				trace("try again "+ totalMatchFound );
				this.scoreValue = totalMatchFound;
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_RIGHT_MOVE));
				animateLines();
			}
		}
		
		private function animateLines():void{
			for(var i=0; i<lines.length; i++){
				
				lines[i].graphics.lineStyle(8,0xE18700, 1);
				TweenLite.to(lines[i], 1, {alpha:1, onComplete:animateLinesComplete, onCompleteParams:[lines[i]]});
			}
		}
		
		private function animateLinesComplete(cn:Connector):void{
				TweenLite.to(cn, 1, {alpha:0.5});
				cn.graphics.lineStyle(8,getColor().color, 0.5);
		}

		var activeDrawLine:Boolean;
		function mouseDownHandler(event:MouseEvent):void
		{
			trace("down");

			for (var i:int=0; i<matchables.length; i++)
			{
				var target:MovieClip = matchables[i] as MovieClip;
				if (target.hitTestPoint(mouseX,mouseY,true))
				{
					startPoint = new Point(matchables[i].x,matchables[i].y);
					activeDrawLine = true;
					startClip = matchables[i];
					startClip.alpha = 0.75;
					break;
				}
			}

			if (activeDrawLine)
			{
				line = new Connector();
				addChild(line);
				lines.push(line);

				line.graphics.lineStyle(6);
				stage.addEventListener(MouseEvent.MOUSE_MOVE,movement);
				line.addEventListener(MouseEvent.CLICK,onLineClicked);
				activeDrawLine = false;
			}
		}


		function mouseUpHandler(event:MouseEvent):void
		{
			trace("up");
			//line.graphics.clear();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,movement);

			var isReleasedonTarget:Boolean;
			///
			for (var i:int=0; i<matchables.length; i++)
			{
				trace("for "+ i);

				var target:MovieClip = matchables[i] as MovieClip;
				trace("target: "+target)
				if (line!=null && target!=null && startClip!=null && target.name.substr(0,1) != startClip.name.substr(0,1) && target != startClip && target.hitTestPoint(mouseX,mouseY,true))
				{
					trace('LINE HIT WITH --------------------------------------- TARGET');
					trace("if "+i);
					endPoint = new Point(matchables[i].x,matchables[i].y);

					line.graphics.clear();
					line.graphics.moveTo(startPoint.x,startPoint.y );
					//line.graphics.lineStyle(8,0x930000);
					line.graphics.lineStyle(8,getColor().color, 0.5);


					// this is the line I was fogetting before;
					line.graphics.lineTo(endPoint.x,endPoint.y);

					endClip = matchables[i];
					endClip.alpha = 0.75;
					startClip.alpha = .75;

					line.startClip = startClip;
					line.endClip = endClip;

					matchables.splice(matchables.indexOf(startClip),1);
					matchables.splice(matchables.indexOf(endClip),1);

					matchDone.push(startClip,endClip);

					isReleasedonTarget = true;
					line = null;

					if (lines.length == dataArr.length)
					{
						resultCheck();
					}

					break;

				}
				else{
					if(startClip!=null)
					startClip.alpha = 1;
				}

			}

			if (! isReleasedonTarget)
			{
				if (line!=null && contains(line))
				{
					lines.splice(lines.indexOf(line),1);
					line.graphics.clear();
					trace(line);
					removeChild(line);
					line = null;
				}
				isReleasedonTarget = false;
			}
			trace("lines : "+lines.length);
		}


		function movement(event:MouseEvent):void
		{
			trace("Move");
			line.graphics.clear();
			line.graphics.moveTo(startPoint.x,startPoint.y );
			line.graphics.lineStyle(6,0x930000, 0.5);

			// this is the line I was fogetting before;
			line.graphics.lineTo(mouseX,mouseY);
		}

		function onLineClicked(e:MouseEvent):void
		{
			//line.graphics.clear();
			var removeLine:Connector = e.currentTarget as Connector;
			matchables.push(removeLine.startClip, removeLine.endClip);
			removeLine.startClip.alpha = 1;
			removeLine.endClip.alpha = 1;

			matchDone.splice(matchDone.indexOf(removeLine.startClip),1);
			matchDone.splice(matchDone.indexOf(removeLine.endClip),1);

			trace(removeLine.x+" "+removeLine.y+ " "+removeLine.width+" "+removeLine.height);
			lines.splice(lines.indexOf(removeLine),1);
			removeChild(removeLine);
			trace(removeLine.x+" "+removeLine.y);
		}

		function getColor():ColorTransform
		{
			var colorArray:Array = new Array(0xFFFFFF, 0xFFFFFF, 0xFFFFFF);//(0xFFFF33,0xFF50FF,0x79DCF4,0xFF3333,0xFFCC33,0x99CC33); 
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);

			var myColor:ColorTransform = new ColorTransform();
			myColor.color = colorArray[randomColorID];

			//myMovieClip.transform.colorTransform = myColor;

			return myColor;
		}
	}
}
