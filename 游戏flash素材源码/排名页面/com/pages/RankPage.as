package com.pages {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.event.*;
	import flash.events.IEventDispatcher;
	
	
	public class RankPage extends MovieClip implements IEventDispatcher {
		
		private var rp:RankPageRes;
		//private var eventHandler:EventHandler = new EventHandler();
		public function RankPage() {
			// constructor code
			rp = new RankPageRes();
			addChild(rp);
			rp.back_btn.addEventListener(MouseEvent.CLICK,onClick);
			rp.start_btn.addEventListener(MouseEvent.CLICK,onClick);
			this.addEventListener(GameEvent.START_GAME,EventHandler.HandleEvent)
			this.addEventListener(GameEvent.TO_MAIN,EventHandler.HandleEvent)
		}
		private function onClick(event:MouseEvent):void{
			if(event.target == rp.back_btn){
				trace("back");
				//trace(this);
				this.dispatchEvent(new Event(GameEvent.TO_MAIN));
			}
			if(event.target == rp.start_btn){
				trace("start");
				this.dispatchEvent(new Event(GameEvent.START_GAME));
			}
		}
	}
	
}
