package com.bbc_icontent.screens
{
	import com.bbc_icontent.EndScreen;
	import com.mcc.interactives.SceneManager;
	import com.mcc.interactives.IEvents.SceneEvents;
	
	import flash.display.MovieClip;
	
	public class ScreenRoomFloorEnd extends EndScreen
	{
		private var _darkLight:MovieClip;
		
		private var _sceneMan:SceneManager;
		public function ScreenRoomFloorEnd()
		{
			super();
			
			_darkLight = dark2light as MovieClip;			
			_sceneMan = new SceneManager(_darkLight);
		}
		
		override public function show():void
		{
			// TODO Auto Generated method stub
			super.show();
			
			_sceneMan.play();
			_sceneMan.addEventListener(SceneEvents.PLAY_ALL_COMPLETE, prepareExit);
		}
		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			_sceneMan.removeEventListener(SceneEvents.PLAY_ALL_COMPLETE, prepareExit);
			super.destroy();
		}
		
		
		
		private function prepareExit(e:SceneEvents):void{
			finished();
		}
	}
}