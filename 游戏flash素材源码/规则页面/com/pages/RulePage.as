package com.pages {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class RulePage extends MovieClip {
		private var rp:RulePageRes;

		public function RulePage() {
			// constructor code
			rp = new RulePageRes();
			rp.begin_btn.addEventListener(MouseEvent.CLICK,onClick)
			this.addChild(rp);
			//为开始按钮加一个监听器
		}
		private function onClick(event:Event):void{
			trace("onclick");
			this.dispatchEvent(new Event("GameEvent.START_GAME"));
		}

	}
	
}
