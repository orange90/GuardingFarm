package game.pages 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import game.event.*;
	
	/**
	 * ...
	 * @author orange
	 * 所有页面的基类。此类实现了不同按钮的不同事件的分发，以免在各子类再重复定义事件监听器
	 * （前提是按钮需要统一命名）
	 */
	public class BasePage extends MovieClip 
	{
		
		protected var eventHandler:EventHandler = new EventHandler();
		public function BasePage() 
		{
		    //其他部分由子类实现
			addAllListnener();
		}
		protected function addAllListnener():void
	    {
			this.addEventListener(GameEvent.START_GAME, eventHandler.HandleEvent)
			this.addEventListener(GameEvent.SHOW_RULE, eventHandler.HandleEvent)
	    	this.addEventListener(GameEvent.SHOW_RANK, eventHandler.HandleEvent)	
			this.addEventListener(GameEvent.TO_MAIN, eventHandler.HandleEvent);
		}
		protected function onClick(event:MouseEvent):void 
		{
			
			switch (event.target.name) {
				case "start_btn":
				    dispatchEvent(new Event(GameEvent.START_GAME));
					break;
				case "rules_btn":
					dispatchEvent(new Event(GameEvent.SHOW_RULE));
					break;
				case "ranking_btn":
					dispatchEvent(new Event(GameEvent.SHOW_RANK));
					break;
				case "back_btn":
					dispatchEvent(new Event(GameEvent.TO_MAIN));
					break;
			}
		}
	}
	

}