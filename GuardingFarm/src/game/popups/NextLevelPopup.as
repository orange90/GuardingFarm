package game.popups 
{
	/**
	 * 此框为继续下一关的动画，调用MonkeyGO类里面的moveToLevel()方法可以实现动画
	 * @author orange
	 */
	import game.event.GameEvent;
	import flash.events.Event;
	import flash.events.MouseEvent
	public class NextLevelPopup extends BasePopup
	{
		private var _monkey:MonkeyGo;
		public function NextLevelPopup() 
		{
			_monkey = new MonkeyGo();
			addChild(_monkey);
			//_monkey.continue_btn.addEventListener(MouseEvent.CLICK, handleNextLevel)//父类已定义onClick
			super();//父类已经侦听了事件了
		}
		public function get monkey():MonkeyGo {//public这个是因为要在外部使用其内部的 moveToNextLevel方法
			return _monkey;
		}
		private function handleNextLevel(event:MouseEvent):void
		{
			_monkey.moveToLevel(gameProcess.level + 1);
			//dispatchEvent(new GameEvent(GameEvent.NEXT_LEVEL);
		}
		
	}

}