package com.bbc_icontent.screens
{

	import com.bbc_icontent.Screen;
	import com.bbc_icontent.custom_elements.Connector;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.objects.Bat;
	import com.bbc_icontent.objects.ClockSkined;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.net.NetConnection;



	public class ScreenKitchen02 extends Screen
	{

		private var sec:int;
		private var quizTime:ClockSkined;

		private var currentBat:Bat;

		private var numBat:int;

		private var Bats:Vector.<MovieClip > ;
		
		private var _startInsClip:ScreenGameStart;
		private var _textline:TextLine;

		public function ScreenKitchen02()
		{
			scoreMax = numBat=10;;
			sec = 50;
			quizTime = clock as ClockSkined;
			quizTime.setup(sec);
			addChild(quizTime);
			quizTime.visible = false;

			
			
			Bats=new Vector.<MovieClip>();
			
			_startInsClip= startInsClip as ScreenGameStart;
			_startInsClip.txt.text = "ev`yo¸‡jv‡K Rv‡j e›`x Ki‡Z G¸‡jvi Ici wK¬K Ki‡Z n‡e|";		
			_startInsClip.visible = false;
			
			_textline = textline as TextLine;
			//this.mouseChildren = false;
		}
		
		private function NextScreen(e:TextLineEvents):void
		{			
			if(e.type== TextLineEvents.TEXTLINE_END){
				_textline.disAppear();	
			}
			
			this.addChild(_startInsClip);
			_startInsClip.addEventListener(LevelEvents.LEVEL_START, startInsClipClicked);
			_startInsClip.visible= true;	
			
		}
		
		private  function startInsClipClicked(e:LevelEvents):void
		{
			trace("startgame=====================");
			this.removeChild(_startInsClip);
			
			quizTime.start();
			runQuiz();
		}

		private function addBats(num:int)
		{

			for (var i:int=0; i<num; i++)
			{
				var newBat:Bat= new Bat();
				newBat.name="bat"+i;
				
				newBat.x=Math.random() *stage.width;
				newBat.y=Math.random() *stage.height;
				newBat.mouseChildren = false;
				newBat.mouseEnabled = false;
				
				this.addChild(newBat);
				newBat.buzzOff();
				Bats.push(newBat); 
			}
			trace("num bats: "+Bats.length);
		}

		

		private var _netCounter:int = 0;
		private function onClickStage(e:MouseEvent)
		{
			trace("clicked===============================");
			var _net:MovieClip=new net();
			_net.name = "_net" + _netCounter;
			_netCounter++;
			_net.x = stage.mouseX;
			_net.y = stage.mouseY;
			this.addChild(_net);
			_net.addEventListener(Event.ENTER_FRAME, _netENTER_FRAME);
			
			var targetBat:Bat=collusionCheck(_net);
			trace("num bats: "+Bats.length+ " targetBat "+targetBat );
			if(targetBat != null){
				targetBat.gotoAndStop("down");
				targetBat.enableBuzz=false;
				targetBat.kill();
				//targetBat.addEventListener(Event.ENTER_FRAME, targetBatENTER_FRAME);
				TweenLite.to(targetBat,6,{y:(stage.height+targetBat.height), onComplete:onBatOutOFStage, onCompleteParams:[targetBat]  });
			}
			
			if(Bats.length == 0){
				quizTime.stopClock();
				quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);				
				this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
				scoreValue = numBat;
			}
			
		}
		
		
		
		
		private function _netENTER_FRAME(e:Event)
		{
			//trace(e.currentTarget.name);

			var _net:MovieClip = e.currentTarget as MovieClip;
			if (_net.currentFrame == _net.totalFrames)
			{
				_net.removeEventListener(Event.ENTER_FRAME, _netENTER_FRAME);
				this.removeChild(_net);
			}

		}
		
		private function targetBatENTER_FRAME(e:Event){
			var _bat:Bat= e.currentTarget as Bat;
			//trace("_bat.currentFrame "+_bat.currentFrame)
			if(_bat.currentFrame == _bat.totalFrames){
				
				_bat.stop();
				_bat.removeEventListener(Event.ENTER_FRAME, targetBatENTER_FRAME);
				TweenLite.to(_bat,1,{y:(stage.height+_bat.height), onComplete:onBatOutOFStage, onCompleteParams:[_bat]  });
			}
		}
		
		private function onBatOutOFStage(_bat:Bat):void{
			this.removeChild(_bat);
		}
		
		private function collusionCheck(_net:MovieClip):Bat{
			var _bat:Bat=null;
			for(var i = 0; i< Bats.length; i++){
				if(Bats[i].hitTestObject(_net)){
					trace("bat colide net "+Bats[i].name);
					_bat=Bats[i] as Bat;
					Bats.splice(i, 1);
					break;
					
				}
			}
			
			return _bat;
		}

		override public function show():void
		{
			trace('Showing ins screen.......');
			
			
			
			//reset();
			super.show();
			_textline.appear();
			_textline.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, NextScreen);
			_textline.addEventListener(TextLineEvents.TEXTLINE_END, NextScreen);
		}

		private function runQuiz():void
		{
			
			restartPartial();
		}

		override public function hide():void
		{
			trace('Hiding ins screen.......');
			quizTime.stopClock();
			quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);			
			super.hide();
		}

		override public function destroy():void
		{
			quizTime.removeEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			quizTime.destroy();
			
			stage.removeEventListener(MouseEvent.CLICK, onClickStage);

			super.destroy();
		}

		override public function restartPartial():void
		{
			addBats(numBat);
			
			stage.addEventListener(MouseEvent.CLICK, onClickStage);
			
			quizTime.visible = true;
			quizTime.addEventListener(TimerEvent.TIMER_COMPLETE, timesUp);
			quizTime.restart();
		}

		function timesUp(e: TimerEvent):void
		{
			scoreValue = numBat-Bats.length;
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}

	}
}