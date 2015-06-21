package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.bbc_icontent.objects.BoyWalk;
	import com.bbc_icontent.objects.ClockSkined;
	import com.greensock.TweenLite;
	import com.mcc.interactives.utils.AfterPlayClip;
	import com.mcc.interactives.utils.DelayCall;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;

	//Edited in FB
	public class ScreenRoomFloor02 extends Screen
	{
		private var dragables:Vector.<Sprite > ;

		private var storePositions:Vector.<Point > ;
		private var dragCurrent:Sprite;
		

		private var plk1:MovieClip, plk2:MovieClip, plk3:MovieClip, plk4:MovieClip, plk5:MovieClip, plk6:MovieClip,
		plk7:MovieClip, plk8:MovieClip, plk9:MovieClip, plk10:MovieClip, plk11:MovieClip, plk12:MovieClip;

		private var plks:Vector.<MovieClip > ;
		

		private var boy:BoyWalk;
		private var stepCounter:int = 0;
		private var stepTarget:int = 6;
		
		private var startIns:ScreenGameStart;
		public function ScreenRoomFloor02()
		{
			// constructor code
			
			//external swf name for message before showing score;
			loadablepath = 'GTH_infograph_firmField_ext_01';

			scoreMax = 1;


			plk1 = wt1 as MovieClip;
			plk2 = wt2 as MovieClip;
			plk3 = wt3 as MovieClip;
			plk4 = wt4 as MovieClip;
			plk5 = wt5 as MovieClip;
			plk6 = wt6 as MovieClip;
			plk7 = wt7 as MovieClip;
			plk8 = wt8 as MovieClip;
			plk9 = wt9 as MovieClip;
			plk10 = wt10 as MovieClip;
			plk11 = wt11 as MovieClip;
			plk12 = wt12 as MovieClip;

			plks = new Vector.<MovieClip>();
			plks.push(plk1, plk2, plk3, plk4, plk5, plk6, plk7, plk8, plk9, plk10, plk11, plk12);

			boy = boywalk as BoyWalk;
			boy.stop();
			boy.mouseEnabled = false;
			boy.mouseChildren=false;
			
			startIns = startInsClip as ScreenGameStart;
		}
		
		private function startInsClick(e:LevelEvents){
			
			startIns.removeEventListener(LevelEvents.LEVEL_START, startInsClick); 
			removeChild(startIns);
			
			for (var i:int=0; i<plks.length; i++)
			{
				plks[i].addEventListener(MouseEvent.CLICK, onClickedplks);
			}
	
			generateRandom();
			glow();
		}
		
		var arr:Array=new Array();
		private function generateRandom()
		{
			
			for (var i:int=0; i<6; i++)
			{
				var myNum:Number = Math.ceil(Math.random() * 2);
				myNum +=  (i * 2);
				arr.push(myNum);
			}

			trace(arr);
		}

		


		private function onClickedplks(e:MouseEvent):void
		{
			var plk:MovieClip = e.currentTarget as MovieClip;
			trace("plk "+plk.name +" correct:"+ "wt" + arr[stepCounter]);
			if (plk.name == "wt" + arr[stepCounter]  )
			{

				boy.stepLeft(plk.x, plk.y);
				stepCounter++;
				if (stepCounter>=stepTarget)
				{
					this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));					
					
					for (var i:int=0; i<plks.length; i++)
					{
						plks[i].removeEventListener(MouseEvent.CLICK, onClickedplks);
					}

					//this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
					trace("Win=======================");
				}
				else
				{
					TweenLite.delayedCall(.5,stepIndicatorGlow);
				}
			}else{
				trace("WRONG=================");
			}
		}


		override public function show():void
		{
			this.addChild(startIns);
			
			
			startIns.addEventListener(LevelEvents.LEVEL_START, startInsClick);
		}



		private function startGame():void
		{			
			glow();
		}


		function glow()
		{
			for (var i:int=0; i<plks.length; i++)
			{
				var mc:MovieClip = plks[i] as MovieClip;
				TweenLite.to(mc, .5,  {onComplete:glowRemoved,  onCompleteParams:[mc],glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30}});
			}
		}


		function glowRemoved(mc:MovieClip)
		{
			TweenLite.to(mc, .5,  {glowFilter:{color:0xFF91e600, alpha:0, blurX:0, blurY:0}});
			if (stepCounter==0)
			{
				stepIndicatorGlow();
			}
		}
		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
		}
		

		function stepIndicatorGlow()
		{
			if (stepCounter>=plks.length)
			{
				return;
			}

			var mc:MovieClip=null;			
			
			for(var i:int=0; i<plks.length; i++){
				
				if(plks[i].name=="wt"+arr[stepCounter]){
					mc=plks[i];
					break;
				}
			}
			
			if(mc!=null)
			TweenLite.to(mc, .5,  {onComplete:glowRemoved,  onCompleteParams:[mc],glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30}});

		}


		override public function restartPartial():void
		{
			
			startGame();
		}


		override public function hide():void
		{
			// TODO Auto Generated method stub
			super.hide();
			
		}


		
	}
}