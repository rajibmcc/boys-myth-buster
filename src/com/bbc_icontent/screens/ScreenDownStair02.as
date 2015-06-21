package com.bbc_icontent.screens
{

	import com.bbc_icontent.Screen;
	import com.bbc_icontent.events.LevelEvents;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.AfterPlayClip;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;

	public class ScreenDownStair02 extends Screen
	{
		private var heroGhost:MovieClip;
		private var ghostAreCommingOut:Boolean;
		private var randTimeToComeOut:Number;
		private var screenStart:ScreenGameStart;
		private var almirah:MovieClip;
		private var almirahClickCount:int, almirahClickTarget:int, timesStopTarget:int, timesStopCount:int;

		private var filterGlowReset:GlowFilter;

		private var _textline:TextLine;
		
		TweenPlugin.activate([GlowFilterPlugin]);

		public function ScreenDownStair02()
		{
			scoreMax = 3;
			timesStopTarget = 3;
			
			filterGlowReset = new GlowFilter(0, 0, 0, 0);
			screenStart = startScreen as ScreenGameStart;
			
			heroGhost = skeletanComeOut as MovieClip;
			heroGhost.stop();
			heroGhost.visible = false;
			
			almirah = almirahClip as MovieClip;
			almirah.mouseChildren = false;
			almirah.stop();
			
			_textline = textline as TextLine;
			_textline.visible = false;
		}
		
		override public function show():void
		{
			addChild(screenStart);
			screenStart.addEventListener(LevelEvents.LEVEL_START, prepareInteractive);
			super.show();
		}
		
		override public function hide():void
		{
			removeChild(screenStart);
			super.hide();
		}
		
		private function prepareInteractive(e:LevelEvents):void{
			ghostAreCommingOut = false;
			removeChild(screenStart);
			startInteractive();
		}
		
		private function startInteractive():void{
			almirah.addEventListener(MouseEvent.CLICK, onAlmirahClicked);
			createGhostWave();
		}
		
		private function createGhostWave():void{
			trace("CREATING GHOST WAVE ------------------------------------------------------");
			almirah.filters = [filterGlowReset];
			almirahClickCount = 0;
			almirahClickTarget = 5 + Math.random() * 5;
			ghostTryingToComeOut();
		}
		
		private function onAlmirahClicked(e:MouseEvent):void
		{
			if(!ghostAreCommingOut) return;
			
			almirahClickCount++;
			trace("almirahClick Taken : " + almirahClickCount);
			
			if (almirahClickCount == almirahClickTarget)
			{
				trace("******** STOPED A GHOST WAVE *********");
				stopedGhostComeOut();
				TweenLite.to(almirah, .3, {glowFilter:{color:0x91e600, alpha:1, blurX:50, blurY:50}});
				//almirah.alpha = .5;
				
				// HAve to stop an certain amount of wave
				timesStopCount++;
				trace("******** STOPED GHOST WAVE COUNT : "+timesStopCount);
				
				if(timesStopCount == timesStopTarget){
					trace("*****@#$@@#$ ALL WAVE STOPED @#$@@#$**********");
					almirah.addEventListener(MouseEvent.CLICK, onAlmirahClicked);
					trace("GAME OVER SO FAR .............................. **********************");
					
					heroGhost.visible = true;
					heroGhost.gotoAndPlay(1);
					AfterPlayClip.callBack(heroGhost, prepareExit);
				}
				else{
					randTimeToComeOut = 2 + Math.random() * 2;
					TweenLite.delayedCall(randTimeToComeOut, createGhostWave);
				}
			}
			else{
				trace("GHOST WILL SHOW UP ANY TIME ......");
				stopedGhostComeOut();
				randTimeToComeOut = Math.random() * 2;
				TweenLite.delayedCall(randTimeToComeOut, ghostTryingToComeOut);
			}
		}
		
		private function ghostTryingToComeOut():void{
			almirah.gotoAndPlay(1);
			ghostAreCommingOut = true;
		}
		
		private function stopedGhostComeOut():void{
			almirah.gotoAndStop(1);
			ghostAreCommingOut = false;
		}
		
		private function prepareExit():void{
			_textline.visible = true;
			_textline.appear();
			_textline.addEventListener(TextLineEvents.TEXTLINE_DISAPPEARED, exitLevel);
			_textline.addEventListener(TextLineEvents.TEXTLINE_END, exitLevel);
		}
		
		private function exitLevel(e:TextLineEvents):void{
			if(e.type == TextLineEvents.TEXTLINE_END) {
				_textline.disAppear();
				return;
			}
			
			this.dispatchEvent(new LevelEvents(LevelEvents.LEVEL_NEXT));
		}

		override public function destroy():void
		{
			super.destroy();
		}

		override public function restartPartial():void
		{
			
		}
	}
}