package com.event {
	import flash.events.Event;
	
	public class GameEvent extends Event {
        public static const START_GAME:String = "start_game";
		public static const SHOW_RULE:String = "show_rule";
		public static const SHOW_RANK:String = "show_rank";
		public static const TO_MAIN:String = "to_main";
		public function GameEvent(eventType:String) {
			super(eventType);
			
		}

	}
	
}
