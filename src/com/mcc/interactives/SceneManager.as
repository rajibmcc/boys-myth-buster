package com.mcc.interactives
{
	import com.mcc.interactives.IEvents.SceneEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class SceneManager extends EventDispatcher
	{
		private var _indexScene:int;
		private var _indexLimit:int;
		private var _scenes:Vector.<MovieClip>;
		private var _sceneCurrent:MovieClip;
		private var _sceneClip:MovieClip;
		private var _playOneAfterAnother:Boolean;
		/**
		 * 
		 * @param args MovieClip
		 * 
		 */		
		public function SceneManager(... args)
		{
			_scenes = new Vector.<MovieClip>();
			_indexScene = 0;
			_indexLimit = args.length;
			_playOneAfterAnother = false;
			
			//First movie clip with visibility = true;
			_sceneCurrent = args[0] as MovieClip;
			_sceneCurrent.stop();
			_scenes.push(_sceneCurrent);
			
			for(var i:int = 1; i< _indexLimit; i++){
				//stop other clip also and hide from displaylist
				_sceneClip = args[i] as MovieClip;
				_sceneClip.stop();
				_sceneClip.visible = false;
				_scenes.push(_sceneClip);
			}
		}
		
		public function get playOneAfterAnother():Boolean
		{
			return _playOneAfterAnother;
		}

		public function set playOneAfterAnother(value:Boolean):void
		{
			_playOneAfterAnother = value;
		}

		public function play():void{
			_sceneCurrent.play();
			_sceneCurrent.addEventListener(Event.ENTER_FRAME, onEnterHandler);
		}
		
		public function stop():void{
			_sceneCurrent.stop();
			_sceneCurrent.removeEventListener(Event.ENTER_FRAME, onEnterHandler);
		}
		
		public function reset():void{
			_sceneCurrent = _scenes[0] as MovieClip;
			_sceneCurrent.gotoAndStop(1);
			_sceneCurrent.visible = true;
			
			for(var i:int = 1; i< _indexLimit; i++){
				//stop other clip also and hide from displaylist
				_sceneClip = _scenes[i] as MovieClip;
				_sceneClip.stop();
				_sceneClip.visible = false;
			}
		}
		
		public function nextScene():void{
			if(_indexScene + 1 < _indexLimit){
				_indexScene ++;
				_sceneClip = _sceneCurrent;
				_sceneClip.visible = false;
				_sceneClip.stop();
				_sceneClip.removeEventListener(Event.ENTER_FRAME, onEnterHandler);
				
				_sceneCurrent = _scenes[_indexScene];
				_sceneCurrent.visible = true;
				_sceneCurrent.gotoAndPlay(1);
				_sceneCurrent.addEventListener(Event.ENTER_FRAME, onEnterHandler);
			}
			else{
				trace("NO SCENE TO PLAY");
				this.dispatchEvent(new SceneEvents(SceneEvents.NO_SCENE));
			}
		}
		
		private function onEnterHandler(e:Event):void{
			if(_sceneCurrent.currentFrame == _sceneCurrent.totalFrames){				
				_sceneCurrent.stop();
				_sceneCurrent.removeEventListener(Event.ENTER_FRAME, onEnterHandler);
				if(_indexScene+1 == _indexLimit){
					trace("********** Last Movie PLAY COMPLETE***************");
					this.dispatchEvent(new SceneEvents(SceneEvents.PLAY_ALL_COMPLETE));
				}
				else{
					trace("Movie PLAY COMPLETE");
					this.dispatchEvent(new SceneEvents(SceneEvents.PLAY_COMPLETE));
				}
				
				if(playOneAfterAnother){
					nextScene();
				}
			}
		}
		
		public function previousScene():void{
			
		}
	}
}