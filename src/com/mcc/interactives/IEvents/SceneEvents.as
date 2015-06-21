package com.mcc.interactives.IEvents
{
	import flash.events.Event;
	
	public class SceneEvents extends Event
	{
		public static var PLAY_COMPLETE:String = "play_complete";
		public static var PLAY_ALL_COMPLETE:String = "play_all_complete";
		public static var NO_SCENE:String = "no_scene";
		public function SceneEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}