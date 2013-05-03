package com.event {
	import flash.events.Event
	public class EventHandler  {
            
		public function EventHandler() {
			// constructor code
			
		}
		public static function HandleEvent(event:Event):void{
			trace("Event is",event.type,event.target);
			switch (event.type){
				case "start_game":
				    trace("handle start_game");
					break;
				case "to_main":
				    trace("handle to_main");
					break;
			}
		}

	}
	
}
