package game.pages 
{
	/**
	 * ...
	 * @author orange
	 */
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import game.event.*;
	public class RulePage extends BasePage
	{
		public var rulePageRes:MovieClip
		public function RulePage() 
		{
			super();//调用父类方法，包括各按钮的事件分发
			rulePageRes = new RulePageRes();
			addChild(rulePageRes);
			rulePageRes.rules_tips.start_btn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
	}

}