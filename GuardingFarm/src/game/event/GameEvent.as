package game.event {
	import flash.events.Event;
	
	public class GameEvent extends Event {
        public static const START_GAME:String = "start_game";
		public static const SHOW_RULE:String = "show_rule";
		public static const SHOW_RANK:String = "show_rank";
		public static const TO_MAIN:String = "to_main";
		public static const NEXT_LEVEL:String = "next_level";
		public static const TIME_OVER:String = "time_over";
		public static const I_KNOW:String = "i_know";
		public static const WIN:String = "win";
		public static const FAIL:String = "fail";
		public function GameEvent(eventType:String) {
			super(eventType);	
		}
	}
	
}
