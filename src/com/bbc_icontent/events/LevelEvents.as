package com.bbc_icontent.events {
	import flash.events.Event;

	public class LevelEvents extends Event {
		public static const LEVEL_START:String = 'level_start';
		public static const LEVEL_SKIP:String = 'level_skip';
		public static const LEVEL_NEXT:String = 'level_next';
		public static const LEVEL_PREVIOUS:String = 'level_previous';
		public static const LEVEL_RESTART:String = 'level_restart';
		public static const LEVEL_RESTART_PARTIAL:String = 'level_restart_partial';
		public static const LEVEL_WRONG_MOVE:String = 'level_wrong_move';
		public static const LEVEL_RIGHT_MOVE:String = 'level_right_move';
		public static const LEVEL_TIMEUP:String = 'level_timeup';
		public static const LEVEL_COMPLETE:String = 'level_complete';
		
		public static const SHOW_MESSAGE:String = 'show_message';
		public static const SHOW_RESULT:String = 'show_result';
		
		private var _params:Object;
		
		public function LevelEvents(type: String, params:Object = null, bubbles: Boolean = false) {
			super(type, bubbles);
			_params = params;
		}
		
		public function get params():Object{
			return _params;
		}
		
	}
}