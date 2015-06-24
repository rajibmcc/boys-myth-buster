package com.bbc_icontent.screens
{

	import com.bbc_icontent.Screen;
	import com.bbc_icontent.objects.ClockSkined;
	import com.bbc_icontent.custom_elements.Connector;
	import com.bbc_icontent.events.LevelEvents;

	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;

	public class ScreenKitchen03 extends Screen
	{

		private var sec:int;
		private var quizTime:ClockSkined;

		private var cl1:MovieClip,cl2:MovieClip,cl3:MovieClip,
		cr1:MovieClip,cr2:MovieClip,cr3:MovieClip
		
		private var batcl1:MovieClip,batcl2:MovieClip,batcl3:MovieClip,
		batcr1:MovieClip,batcr2:MovieClip,batcr3:MovieClip;

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
		
		private var _startInsClip:ScreenGameStart;

		public function ScreenKitchen03()
		{
			scoreMax = 3;
			sec = 60;
			quizTime = clock as ClockSkined;
			quizTime.setup(sec);
			addChild(quizTime);
			quizTime.visible = false;

			//left side
			cl1 = l1 as MovieClip;
			cl2 = l2 as MovieClip;
			cl3 = l3 as MovieClip;
			
			matchablesLeft=new Vector.<MovieClip>();
			matchablesLeft.push(cl1, cl2, cl3 );

			//right side;
			cr1 = r1 as MovieClip;
			cr2 = r2 as MovieClip;
			cr3 = r3 as MovieClip;
			
			matchablesRight=new Vector.<MovieClip>();
			matchablesRight.push(cr1, cr2, cr3);

			//data array;
			dataArr.push("G‡KK R‡bi cyiælv‡½i AvKvi-AvK…wZ"+separetor+"G‡KK iKg n‡Z cv‡i| Z‡e G Kvi‡Y kvixwiK m¤c‡K©i †¶‡Î †Kv‡bv mgm¨v nq bv|",
 						"KviI KviI cyiælv½ GKUz evuKv‡bv n‡Z cv‡i "+separetor+"hv †Kej cyiælv½ DwÌZ n‡jB †evSv hvq| Z‡e GB evuKv nIqvi e¨vcviUv ¯^vfvweK|", 
 						"mšÍvb Rb¥`v‡bi m¶gZv ev De©iZv Av‡Q wK †bB "+separetor+"Zv cyiælv‡½i AvKvi-AvK…wZi Ici wbf©i K‡i bv|");


			matchables=new Vector.<MovieClip>();
			matchables = matchablesLeft.concat(matchablesRight);
			//hide all matching parts
			showHideMatching(matchables, false);

			matchDone=new Vector.<MovieClip>();





			prepareMatching(dataArr, matchablesLeft, matchablesRight );

			lines=new Vector.<Connector>();
			
			batcl1 = batL1 as MovieClip;
			batcl2 = batL2 as MovieClip;
			batcl3 = batL3 as MovieClip;
			
			
			batcr1 = batR1 as MovieClip;
			batcr2 = batR2 as MovieClip;
			batcr3 = batR3 as MovieClip; 
			
			
			animateBat(batcl1);
			animateBat(batcl2);
			animateBat(batcl3);
			
			
			animateBat(batcr1);
			animateBat(batcr2);
			animateBat(batcr3);
			
			
			// game start msg 
			_startInsClip= startInsClip as ScreenGameStart;
			_startInsClip.txt.text="ivbœvN‡i GLbI K‡qKwU ev`yo i‡q †M‡Q| GB ev`yo¸‡jv‡K Zvov‡Z n‡j †Zvgv‡K wb‡P †`Iqv evu-w`‡Ki evK¨vsk¸‡jv‡K Wvbw`‡Ki evK¨vs‡ki mv‡_ †gjv‡Z n‡e|";		
			_startInsClip.visible= false;
			

		}


		private function animateBat(mc:MovieClip)
		{
			var yy:int=Math.random()*30;
			var time:Number=Math.random()*2+1;
			var myTween:TweenLite = new TweenLite(mc,time,{y:(mc.y+yy), onComplete:reverseTween,onReverseComplete:restartTween});
			
			function reverseTween():void
			{
				myTween.reverse();
			}
			function restartTween():void
			{
				myTween.restart();
			}
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

		override public function show():void
		{
			trace('Showing ins screen.......');
			
			
			this.addChild(_startInsClip);
			_startInsClip.addEventListener(LevelEvents.LEVEL_START, startInsClipClicked);
			_startInsClip.visible= true;	
			
			super.show();
		}
		
		private  function startInsClipClicked(e:LevelEvents):void
		{
			trace("startgame=====================");
			this.removeChild(_startInsClip);
			
			quizTime.start();
			restartPartial();
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

		override public function restartPartial():void
		{
			matchables=new Vector.<MovieClip>();
			matchables = matchablesLeft.concat(matchablesRight);


			for (var j in matchables)
			{
				matchables[j].alpha = 1;
			}

			for (var i in lines)
			{
				removeChild(lines[i]);
			}

			lines=new Vector.<Connector>();

			//adding matching listener
			addMatchingListener();

			//hide all matching parts
			showHideMatching(matchables, true);
			quizTime.visible = true;

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

			_random(cntLeft);
			_random(cntRight);
		}

		private function _random( cnt:Vector.<MovieClip>)
		{
			for (var i=0; i<cnt.length; i++)
			{
				var randomPos:int = Math.random() * cnt.length;
				var txt:String = cnt[i].txt.text;
				cnt[i].txt.text = cnt[randomPos].txt.text;
				cnt[randomPos].txt.text = txt;
			}
		}

		private function showHideMatching(cnt:Vector.<MovieClip>, visibility:Boolean):void
		{
			for (var i=0; i<cnt.length; i++)
			{
				cnt[i].visible = visibility;
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

			if (totalMatchFound == 0)
			{
				removeMatchingListener();
				trace("FAILED "+ totalMatchFound);
				this.scoreValue = 0;
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
			}
			else
			{
				removeMatchingListener();
				trace("try again "+ totalMatchFound );
				this.scoreValue = totalMatchFound;
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
			}
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
				trace("target: "+target);
				if (line!=null && target!=null && startClip!=null && target.name.substr(0,1) != startClip.name.substr(0,1) && target != startClip && target.hitTestPoint(mouseX,mouseY,true))
				{
					trace('LINE HIT WITH --------------------------------------- TARGET');
					trace("if "+i);
					endPoint = new Point(matchables[i].x,matchables[i].y);

					line.graphics.clear();
					line.graphics.moveTo(startPoint.x,startPoint.y );
					//line.graphics.lineStyle(8,0x930000);
					line.graphics.lineStyle(8,getColor().color);


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
				else
				{
					if (startClip!=null)
					{
						startClip.alpha = 1;
					}
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

			var colorArray:Array = new Array(0xFFFF33,0xFF50FF,0x79DCF4,0xFF3333,0xFFCC33,0x99CC33);
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);

			var myColor:ColorTransform = new ColorTransform();
			myColor.color = colorArray[randomColorID];

			//myMovieClip.transform.colorTransform = myColor;

			return myColor;

		}
	}
}