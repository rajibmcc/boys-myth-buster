package com.bbc_icontent.screens
{
	import com.bbc_icontent.Screen;
	import com.mcc.interactives.SceneManager;
	import com.mcc.interactives.IEvents.SceneEvents;
	import com.mcc.interactives.IEvents.TextLineEvents;
	import com.mcc.interactives.component.TextLine;
	import com.mcc.interactives.utils.AfterPlayClip;
	
	import flash.display.MovieClip;
	
	public class ScreenBedroom extends Screen
	{
		private var movie_01:MovieClip;
		private var movie_02:MovieClip;
		private var textLine:TextLine;
		private var sceneManager:SceneManager;
		public function ScreenBedroom()
		{
			super();
			
			movie_01 = mov01 as MovieClip;
			movie_02 = mov02 as MovieClip;
			sceneManager = new SceneManager(movie_01, movie_02);
			
			textLine = text_line as TextLine;
			textLine.syncPoints = [2];
			
			sceneManager.play();
		}
		
		override public function show():void{
			textLine.appear();
			textLine.addEventListener(TextLineEvents.TEXTLINE_SYNC, onTextSync);
		}	
		
		private function onTextSync(e:TextLineEvents):void{
			sceneManager.nextScene();
		}
	}
}