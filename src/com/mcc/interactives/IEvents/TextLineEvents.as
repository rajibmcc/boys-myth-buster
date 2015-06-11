package com.mcc.interactives.IEvents
{
	import flash.events.Event;
	
	public class TextLineEvents extends Event
	{
		public static var TEXTLINE_NEXT:String = "textline_next";
		public static var TEXTLINE_SKIP:String = "textline_skip";
		public static var TEXTLINE_END:String = "textline_end";
		public static var TEXTLINE_DISAPPEARED:String = "textline_disappeared";
		public static var TEXTLINE_APPEARED:String = "textline_appeared";
		public static var TEXTLINE_SYNC:String = "textline_sync";
		public function TextLineEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}