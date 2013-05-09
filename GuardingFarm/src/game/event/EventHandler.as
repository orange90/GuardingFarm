/*事件由此类统一处理，此类用时需要实例化
 * author:orange90
 * date:2013-4-24
 */
package game.event {
	import game.pages.*;
	import flash.display.MovieClip;
	import flash.events.Event
	import flash.ui.Mouse;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	public class EventHandler extends MovieClip {
        public  var pageArr:Array;  
		private var _gameStage:Object;   //游戏舞台
		private var _currentPage:MovieClip;  //当前画面
		public function EventHandler() {
			// constructor code
			
		}
		public  function HandleEvent(event:Event):void{
			_gameStage = event.target.parent;
			_currentPage = MovieClip(event.target);
			switch (event.type){
				case "start_game":
					StartGame();
					break;
				case "to_main":
				    ToMain();
					break;
				case "show_rule":
					ShowRule();
					break;
				case "show_rank":
					ShowRank();
					break;
				case "next_level":
					//弹出提示,提示按钮阻塞执行,按了提示按钮后准备开始,准备开始完后就游戏开始
					GotoNextLevel();
					break;
				case "win":
					gotoWinPage();
					break;
				case "fail":
					gotoFailPage();
					break;
			
			}
		}
	    private  function StartGame():void {
			clearStageForNextPage()//清除舞台所有元素，显示新元素（以下同）
			//_gameStage.addChild(new GamePage());
			//_gameStage.addChild(new Level());
			clearStageForNextPage()
			_gameStage.addChild(new GamePage());
		}
		private  function ShowRule():void {
			clearStageForNextPage();
			var rulePage:RulePage = new RulePage();
			TweenLite.from(rulePage.rulePageRes.rules_tips, 1, {x: -1000, y:(480-rulePage.rulePageRes.rules_tips.height)/2, ease: Power0.easeOut, alpha:0});
			TweenLite.to(rulePage.rulePageRes.rules_tips, 1, {x:(854-rulePage.rulePageRes.rules_tips.width)/2, y:(480-rulePage.rulePageRes.rules_tips.height)/2, ease: Power0.easeOut, alpha:1});
			_gameStage.addChild(rulePage);
		}
		private function ShowRank():void
		{
			clearStageForNextPage()
			_gameStage.addChild(new RankPage());
		}
		private function ToMain():void
		{
			clearStageForNextPage()
			_gameStage.addChild(new Index());
		}
		private function GotoNextLevel():void
		{
			//弹出tips
			//tips的按钮addEventListener
			//点了之后才准备开始
			clearStageForNextPage()
			if (gameProcess.level == 4)
			{
				//跳到最后得分页面,并且提交得分。。。。。。。。。。。。
				gotoWinPage();
			}
			gameProcess.level++;
			_gameStage.addChild(new GamePage());
			
		}
		private function gotoFailPage():void
		{
			flash.ui.Mouse.show();
			clearStageForNextPage();
			_gameStage.addChild(new FailPage());
		}
		private function gotoWinPage():void
		{
			clearStageForNextPage();
			_gameStage.addChild(new WinPage());
		}
		
		private function clearStageForNextPage():void
		{
			var numChildrenOfGameStage:uint = _gameStage.numChildren
			for (var i:uint = 0; i<numChildrenOfGameStage ; i++)
			{
				_gameStage.removeChildAt(0);
			}
		}
		
	}
}
