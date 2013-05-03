package com {
	
	import flash.display.MovieClip;
	
	
	public class Main extends MovieClip {
		
		private var _index:IndexRes;
		public function Main() {
			// constructor code
			_index = new IndexRes();
			addChild(_index);
		}
	}
	
}
