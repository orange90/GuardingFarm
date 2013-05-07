package game.popups 
{
	import flash.display.MovieClip;
	import game.event.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author orange
	 * 此类为弹出框的基类
	 */
	public class BasePopup extends MovieClip
	{
		protected var eventHandler:EventHandler = new EventHandler();
		public function BasePopup() 
		{
			//其他部分由子类实现
			addAllListnener();
		}
		protected function addAllListnener():void
	    {
			this.addEventListener(GameEvent.NEXT_LEVEL, eventHandler.HandleEvent)
		}
		protected function onClick(event:MouseEvent):void 
		{
			
			switch (event.target.name) {
				case "continue_btn":
				    dispatchEvent(new Event(GameEvent.NEXT_LEVEL));
					break;
			}
		}
	}

}