package game.pages
{
	/**
	 * ...
	 * @author orange
	 */
	import game.popups.NextLevelPopup;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import game.event.*;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	import com.greensock.easing.*;
	import com.greensock.TweenLite
	
	public class GamePage extends BasePage
	{
		private const SCREEN_WIDTH:uint = 659;
		private const SCREEN_HEIGHT:uint = 466;
		private const BOARD_WIDTH:Number = 666.45;
		private const BOARD_HEIGHT:Number = 264.8;
		private const SCORE_BOARD_WIDTH:Number = 180;
		private const SCORE_BOARD_HEIGHT:Number = 210;
		
		//下面二行作用是让编译器把这几个类也包括进来，不然编译完后运行时会在getDefinitionByName函数后面报错
		Tip1; Tip3; Tip4;
		level1_score;level2_score;level3_score;level4_score;
		
		//一个游戏页面需要下面三种资源：1.游戏背景 2.记分牌 3.关卡发生器
		private var _gamePage:GamePageRes;
		private var _scoreBoard:MovieClip;
		private var _level:Level = new Level();
		private var _eventHandler:EventHandler = new EventHandler();
		private var _readyAndGoTips:ReadyAndGoTips = new ReadyAndGoTips();
		private var _keepTime:KeepTime = new KeepTime();
		private var _tip:*; //关卡开始前的提示
		private var _mouseHandler:MouseHandler = new MouseHandler(); //处理老鼠被点击后的一个类
		private var _shovel:Shovel = new Shovel();
		
		//用于存储左上方的水果图标及得分的引用
		private var _levelFruitIcon:Array;
		private var _levelFruitScore:Array;
		
		private var _scoreToPass:uint;
		
		public function GamePage()
		{
			super();
			initStage();
			_levelFruitIcon = new Array(
										_gamePage.vegetables.ternip,
										_gamePage.vegetables.carrot,
										_gamePage.vegetables.cabbage,
										_gamePage.vegetables.eggplant,
										_gamePage.vegetables.pumpkids,
										_gamePage.vegetables.apple,
										_gamePage.vegetables.pear,
										_gamePage.vegetables.mango,
										_gamePage.vegetables.watermelon
										);
			_levelFruitScore = new Array(
										_gamePage.vegetables.score_ternip,
										_gamePage.vegetables.score_carrot,
										_gamePage.vegetables.score_cabbage,
										_gamePage.vegetables.score_eggplant,
										_gamePage.vegetables.score_pumpkids,
										_gamePage.vegetables.score_apple,
										_gamePage.vegetables.score_pear,
										_gamePage.vegetables.score_mango,
										_gamePage.vegetables.score_watermelon
										);
			initIcon();
			this.addEventListener(GameEvent.TIME_OVER, checkThisLevel);
			this.addEventListener(GameEvent.NEXT_LEVEL, _eventHandler.HandleEvent);
			this.addEventListener(MouseEvent.CLICK, _mouseHandler.handleMouseClick);
			this.addEventListener(GameEvent.WIN, _eventHandler.HandleEvent);
			this.addEventListener(GameEvent.FAIL, _eventHandler.HandleEvent);
			addChild(_shovel);
			initMouseIcon();
			
			var settingFile:XML = XMLSaver.getXMLdata();
			var thisLevelSetting:XML = new XML(settingFile.level.(@id == gameProcess.level));
			_scoreToPass = thisLevelSetting.destScore;
			
			_readyAndGoTips.addEventListener("ready_over", startKeepTime);
			_readyAndGoTips.addEventListener("ready_over", startGame)
			_keepTime.addEventListener(GameEvent.TIME_OVER, checkThisLevel);
			
			_mouseHandler.addEventListener("add2sec", add2Sec);//加两秒
			_mouseHandler.addEventListener("minus2sec", minus2Sec);//减两秒
			_level.addEventListener("minus2sec", minus2Sec);//减两秒
		}
		
		private function initMouseIcon():void
		{
			flash.ui.Mouse.hide();
			addEventListener(Event.ENTER_FRAME,moveMouseIcon)
		}
		private function moveMouseIcon(event:Event):void
		{
			_shovel.x = mouseX;
			_shovel.y = mouseY;
			//下面两行很有必要，否则会被铲子图案本身挡住鼠标。
			_shovel.mouseEnabled = false; 
			_shovel.mouseChildren=false
			setChildIndex(_shovel, numChildren - 1);//放在最上面
		}
		
		private function initStage():void //初始化舞台显示（但不包括各关卡的提示框和地鼠）
		{
			gameProcess.appleScore = 0;
			gameProcess.pearScore = 0;
			gameProcess.ternipScore = 0;
			gameProcess.eggplantScore = 0;
			gameProcess.pumpkidsScore = 0;
			gameProcess.watermelonScore = 0;
			gameProcess.carrotScore = 0;
			gameProcess.cabbageScore = 0;
			gameProcess.mangoScore = 0;
			
			if (gameProcess.level == 1)//第一关重设分数
			{
				gameProcess.total_score = 0; 
			}
			
			_gamePage = new GamePageRes();
			addChild(_gamePage);
			chooseTip(); //根据关卡选择提示
			
			//根据不同关卡加载不同资源
			var LevelScoreClass:Class = getDefinitionByName ("level" + gameProcess.level + "_score") as Class;
			_scoreBoard = new LevelScoreClass();
			_scoreBoard.x = BOARD_WIDTH;
			_scoreBoard.y = BOARD_HEIGHT;
			_scoreBoard.width = SCORE_BOARD_WIDTH;
			_scoreBoard.height = SCORE_BOARD_HEIGHT;
			addChild(_scoreBoard);
		}
		
		private function chooseTip():void
		{	
			if (gameProcess.level == 1 || gameProcess.level == 3 || gameProcess.level == 4)
			{
				var Tips:Class = getDefinitionByName("Tip" + gameProcess.level) as Class
				var tips:MovieClip = new Tips();
				TweenLite.from(tips, 1, { x:-500, y:(SCREEN_HEIGHT - tips.height) / 2, ease:Power2.easeOut, alpha:0 } );
				TweenLite.to(tips, 1, { x:(SCREEN_WIDTH - tips.width) / 2, y:(SCREEN_HEIGHT - tips.height) / 2, ease:Power2.easeOut, alpha:1 } );
				
				/*tips.x = (SCREEN_WIDTH - tips.width) / 2
				tips.y = (SCREEN_HEIGHT - tips.height) / 2*/
				addChild(tips);
				tips.iknow_btn.addEventListener(MouseEvent.CLICK, startPrepare)
			}
			
			if (gameProcess.level == 2)//第二关与第一关类似，故此关没提示，直接播放准备开始
			{
				addChild(_readyAndGoTips);
				_readyAndGoTips.playTips();
			}
		}
		
		private function startGame(event:Event):void
		{
			_keepTime.x = 3;
			_keepTime.y = 9;
			addChild(_keepTime);//添加时钟
			addChild(_level);//添加关卡
			_level.startLevel();//关卡开启
			_scoreBoard.addEventListener(Event.ENTER_FRAME, renewScore);
		}
		
		private function renewScore(event:Event):void
		{
			_scoreBoard.current.text = gameProcess.total_score;
			_scoreBoard.needed.text = _scoreToPass;
			
			_gamePage.vegetables.score_apple.text = gameProcess.appleScore.toString();
			_gamePage.vegetables.score_pear.text = gameProcess.pearScore.toString();
			_gamePage.vegetables.score_ternip.text = gameProcess.ternipScore.toString();
			_gamePage.vegetables.score_eggplant.text = gameProcess.eggplantScore.toString();
			_gamePage.vegetables.score_pumpkids.text = gameProcess.pumpkidsScore.toString();
			_gamePage.vegetables.score_watermelon.text = gameProcess.watermelonScore.toString();
			_gamePage.vegetables.score_carrot.text = gameProcess.carrotScore.toString();
			_gamePage.vegetables.score_cabbage.text = gameProcess.cabbageScore.toString();
			_gamePage.vegetables.score_mango.text = gameProcess.mangoScore.toString();
		}
		
		private function checkThisLevel(event:Event):void
		{
			_level.stopLevel()
			
			//如果分数达标，则显示猴子那个动画
			if (gameProcess.total_score >= _scoreToPass)
			{
				var monkeyMC:NextLevelPopup = new NextLevelPopup();
				monkeyMC.x = (SCREEN_WIDTH - monkeyMC.width) / 2;
				monkeyMC.y = (SCREEN_HEIGHT - monkeyMC.height) / 2;
				addChild(monkeyMC);
				if (gameProcess.level == 4)
				{
					dispatchEvent(new GameEvent(GameEvent.WIN));
					flash.ui.Mouse.show();
				}
				else
				{
					TweenLite.from(monkeyMC, 1, { x:-500, y:(SCREEN_HEIGHT - monkeyMC.height) / 2, ease:Power2.easeOut, alpha:0 } );
				    TweenLite.to(monkeyMC, 1, { x:(SCREEN_WIDTH - monkeyMC.width) / 2, y:(SCREEN_HEIGHT - monkeyMC.height) / 2, ease:Power2.easeOut, alpha:1, onComplete:monkeyGoToNextLevel, onCompleteParams:[monkeyMC] } );
					
				}
			}
			//如果分数不达标，则显示失败那个页面
			else
			{
				this.dispatchEvent(new GameEvent(GameEvent.FAIL));
			}
		}
		private function monkeyGoToNextLevel(_monkey:NextLevelPopup):void //猴子走到下一关
		{
			_monkey.monkey.moveToLevel(gameProcess.level + 1);
			_monkey.monkey.continue_btn.addEventListener(MouseEvent.CLICK, gotoNextLevel)//点击继续图标进入下一关
		}
		private function startKeepTime(event:Event):void//开始计时
		{
			_keepTime.startKeepTime();
		}
		
		private function startPrepare(event:MouseEvent):void //移除对话框，然后播放准备开始动画
		{
			removeChild(event.target.parent);
			addChild(_readyAndGoTips);
			_readyAndGoTips.playTips();
		}
		
		private function gotoNextLevel(event:MouseEvent):void
		{
			if (gameProcess.level == 4)
			{
				//转到通关页面
				
			}
			else
			{
				//转到下一关
				dispatchEvent(new GameEvent(GameEvent.NEXT_LEVEL));
			}
		}
		
		//给总时间加2秒
		private function add2Sec(event:Event):void
		{
			_keepTime.add2Sec();
			var add2:Add2Sec = new Add2Sec();
			var startPoint:Point = new Point(_mouseHandler.clickedX , _mouseHandler.clickedY);
			var endPoint:Point = new Point(0, 0);
			TweenLite.from(add2, 0, {x: _mouseHandler.clickedX, y:_mouseHandler.clickedY, ease: Back.easeOut});
			TweenLite.to(add2, 3, {x: 0, y:0, ease: Back.easeOut, alpha:0.5, visible: false, onComplete: removeFlyingTime, onCompleteParams: [add2]});
			add2.x = startPoint.x;
			add2.y = startPoint.y + 10;
			addChild(add2);
			
			//add2.moveTo(startPoint, endPoint);
			trace("2 sec is added");
		}
		
		//给总时间减2秒
		private function minus2Sec(event:Event):void
		{
			_keepTime.minus2Sec();
			var minus2:Minus2Sec = new Minus2Sec();
			var startPoint:Point;
			if (event.target == "[object Level]")  //由level类触发的话，表明是毒蛇到期未移除所引发的
			{
				startPoint = new Point(_level.removedMouseX, _level.removedMouseY);
			}
			else
			{
				startPoint = new Point(_mouseHandler.clickedX, _mouseHandler.clickedY);
				_level.sisterIsHit = true;
				//dispatchEvent(new Event("sister_is_hit");
			}
			var endPoint:Point = new Point(0, 0);
			minus2.x = startPoint.x;
			minus2.y = startPoint.y + 10;
			TweenLite.from(minus2, 0, {x: startPoint.x, y:startPoint.y, ease: Back.easeOut});
			TweenLite.to(minus2, 3, {x: endPoint.x, y:endPoint.y, ease: Back.easeOut, alpha:0.5, visible: false, onComplete: removeFlyingTime, onCompleteParams: [minus2]});
			addChild(minus2);
			//minus2.moveTo(startPoint, endPoint);
			
		}
		
		private function removeFlyingTime(_timeObj:MovieClip):void
		{
			_timeObj.visible = false;
			if (this != null && _timeObj != null)
			{
				this.removeChild(_timeObj);
			}
		}
		
		//初始化水果栏图标与其个数栏显示
		private function initIcon():void
		{
			for (var i:uint = 1; i < _gamePage.vegetables.numChildren; i++)
			{
				_gamePage.vegetables.getChildAt(i).visible = false;
			}
			for (i = 0; i < gameProcess.level + 1; i++)
			{
				_levelFruitIcon[i].visible = true;
				_levelFruitScore[i].visible = true;
			}
			_levelFruitIcon[gameProcess.level + 4].visible = true;
			_levelFruitScore[gameProcess.level + 4].visible = true;
		}
	}

}