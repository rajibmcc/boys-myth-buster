package com.bbc_icontent
{
	public class ScoreLevel
	{
		private var _scoreLimit:int;
		private var _scoreCurrent:int;
		public function ScoreLevel(current:int, limit:int)
		{
			_scoreCurrent = current;
			_scoreLimit = limit;
		}	

		public function get scoreCurrent():int
		{
			return _scoreCurrent;
		}

		public function set scoreCurrent(value:int):void
		{
			_scoreCurrent = value;
		}

		public function get scoreLimit():int
		{
			return _scoreLimit;
		}

		public function set scoreLimit(value:int):void
		{
			_scoreLimit = value;
		}
		
		public function get scoreString():String{
			return _scoreCurrent+'/'+_scoreLimit;
		}

	}
}