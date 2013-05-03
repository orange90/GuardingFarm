package com.pages 
{
	/**
	 * ...
	 * @author orange
	 */
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import com.event.*;
	public class RulePage extends basePage
	{
		private var _rulePage:MovieClip
		public function RulePage() 
		{
			super();//调用父类方法，包括各按钮的事件分发
			_rulePage = new RulePageRes();
			addChild(_rulePage);
			_rulePage.start_btn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
	}

}