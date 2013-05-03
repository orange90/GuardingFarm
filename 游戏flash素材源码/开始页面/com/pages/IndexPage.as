package com.pages {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class IndexPage extends MovieClip {
		
		private var _index:IndexRes;
		public function IndexPage() {
			// constructor code
			_index = new IndexRes();
			addChild(_index);
			this._index.start_btn.addEventListener(MouseEvent.CLICK,onClick)
			this._index.rules_btn.addEventListener(MouseEvent.CLICK,onClick)
			this._index.rules_btn.addEventListener(MouseEvent.CLICK,onClick)
		}
		private function onClick(event:MouseEvent):void{
			if (event.target == this._index.start_btn){
				//载入关卡页面
				dispatchEvent(new Event("GameEvent.START_GAME"));
			}
			if (event.target == this._index.rules_btn){
				//载入规则页面
				dispatchEvent(new Event("GameEvent.SHOW_RULE"));
			}
			if (event.target == this._index.ranking_btn){
				//载入排名页面
				dispatchEvent(new Event("GameEvent.SHOW_RANK"));
			}
		}
	}
	
}
