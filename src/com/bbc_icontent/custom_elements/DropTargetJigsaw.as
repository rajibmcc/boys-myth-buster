package  com.bbc_icontent.custom_elements{
	import flash.display.Sprite;
	
	public class DropTargetJigsaw extends Sprite{
		private var _empty:Boolean;
		public function DropTargetJigsaw() {
			// constructor code
			_empty = true;
		}
		
		public function set empty(value:Boolean):void{
			_empty = value;
		}
		public function get empty():Boolean{
			return _empty;
		}

	}
	
}
