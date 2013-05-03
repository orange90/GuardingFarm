package com.pages
{
	/**
	 * ...
	 * @author orange
	 */
	import com.popups.NextLevelPopup;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.event.*;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.ui.Mouse;
	//import flash.ui.Mouse;
	
	public class GamePage extends basePage
	{
		private const SCREEN_WIDTH:uint = 659;
		private const SCREEN_HEIGHT:uint = 466;
		private const BOARD_WIDTH:Number = 666.45;
		private const BOARD_HEIGHT:Number = 264.8;
		private const SCORE_BOARD_WIDTH:Number = 180;
		private const SCORE_BOARD_HEIGHT:Number = 210;
		
		//一个游戏页面需要下面三种资源：1.游戏背景 2.记分牌 3.关卡发生器
		private var _gamePage:GamePageRes;
		private var _scoreBoard:*;
		private var _level:Level = new Level();
		private var _eventHandler:EventHandler = new EventHandler();
		private var _readyAndGoTips:ReadyAndGoTips = new ReadyAndGoTips();
		private var _keepTime:KeepTime = new KeepTime();
		private var _tip:*; //关卡开始前的提示
		private var _mouseHandler:MouseHandler = new MouseHandler(); //处理老鼠被点击后的一个类
		private var _shovel:Shovel = new Shovel();
		
		private var _scoreToPass:uint;
		
		public function GamePage()
		{
			super();
			
			initStage();
			initIcon();
			this.addEventListener(GameEvent.TIME_OVER, checkThisLevel);
			this.addEventListener(GameEvent.NEXT_LEVEL, _eventHandler.HandleEvent);
			this.addEventListener(MouseEvent.CLICK, _mouseHandler.handleMouseClick);
			this.addEventListener(GameEvent.WIN, _eventHandler.HandleEvent);
			this.addEventListener(GameEvent.FAIL, _eventHandler.HandleEvent);
			addChild(_shovel);
			initMouseIcon();
			
			var settingFile:XML = XMLParser.getXMLdata();
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
			//Mouse.hide()
			addEventListener(Event.ENTER_FRAME,moveMouseIcon)
		}
		private function moveMouseIcon(event:Event):void
		{
			_shovel.x = mouseX;
			_shovel.y = mouseY;
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
			
			_gamePage = new GamePageRes();
			addChild(_gamePage);
			chooseTip(); //根据关卡选择提示
			
			//根据不同关卡加载不同资源
			if (gameProcess.level == 1)
			{
				gameProcess.total_score = 0; //第一关需要把分数重设为0
				
				_scoreBoard = new level1_score();
				_scoreBoard.x = BOARD_WIDTH;
				_scoreBoard.y = BOARD_HEIGHT;
				_scoreBoard.width = SCORE_BOARD_WIDTH;
				_scoreBoard.height = SCORE_BOARD_HEIGHT;
				addChild(_scoreBoard);
			}
			if (gameProcess.level == 2)
			{
				_scoreBoard = new level2_score();
				_scoreBoard.x = BOARD_WIDTH;
				_scoreBoard.y = BOARD_HEIGHT;
				_scoreBoard.width = SCORE_BOARD_WIDTH;
				_scoreBoard.height = SCORE_BOARD_HEIGHT;
				addChild(_scoreBoard);
			}
			if (gameProcess.level == 3)
			{
				
				_scoreBoard = new level3_score();
				_scoreBoard.x = BOARD_WIDTH;
				_scoreBoard.y = BOARD_HEIGHT;
				_scoreBoard.width = SCORE_BOARD_WIDTH;
				_scoreBoard.height = SCORE_BOARD_HEIGHT;
				addChild(_scoreBoard);
			}
			if (gameProcess.level == 4)
			{
				_scoreBoard = new level4_score();
				_scoreBoard.x = BOARD_WIDTH;
				_scoreBoard.y = BOARD_HEIGHT;
				_scoreBoard.width = SCORE_BOARD_WIDTH;
				_scoreBoard.height = SCORE_BOARD_HEIGHT;
				addChild(_scoreBoard);
			}
		}
		
		private function chooseTip():void
		{
			if (gameProcess.level == 1)
			{
				_tip = new Tip1();
				_tip.x = (SCREEN_WIDTH - _tip.width) / 2
				_tip.y = (SCREEN_HEIGHT - _tip.height) / 2
				addChild(_tip);
				_tip.iknow_btn.addEventListener(MouseEvent.CLICK, startPrepare)
			}
			if (gameProcess.level == 3)
			{
				_tip = new Tip3();
				_tip.x = (SCREEN_WIDTH - _tip.width) / 2
				_tip.y = (SCREEN_HEIGHT - _tip.height) / 2
				addChild(_tip);
				_tip.iknow_btn.addEventListener(MouseEvent.CLICK, startPrepare)
			}
			if (gameProcess.level == 4)
			{
				_tip = new Tip4();
				_tip.x = (SCREEN_WIDTH - _tip.width) / 2
				_tip.y = (SCREEN_HEIGHT - _tip.height) / 2
				addChild(_tip);
				_tip.iknow_btn.addEventListener(MouseEvent.CLICK, startPrepare)
			}
			//第二关与第一关类似，故此关没提示，直接播放准备开始
			if (gameProcess.level == 2)
			{
				addChild(_readyAndGoTips);
				_readyAndGoTips.playTips();
			}
		}
		
		private function startGame(event:Event):void
		{
			_keepTime.x = 3;
			_keepTime.y = 9;
			addChild(_keepTime);
			
			addChild(_level);
			_level.startLevel();
			//dispatchEvent(new Event("level_start"));
			_scoreBoard.addEventListener(Event.ENTER_FRAME, renewScore)
		
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
		   // _gamePage.vegetables.score_mango.text = gameProcess.mangoScore.toString();
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
				if (gameProcess.level != 4)
				{
					monkeyMC.monkey.moveToLevel(gameProcess.level + 1);
				}
				monkeyMC.monkey.continue_btn.addEventListener(MouseEvent.CLICK, gotoNextLevel)
					//点击继续图标进入下一关
			}
			//如果分数不达标，则显示失败那个页面
			else
			{
				this.dispatchEvent(new GameEvent(GameEvent.FAIL));
			}
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
				dispatchEvent(new GameEvent(GameEvent.WIN));
				flash.ui.Mouse.show();
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
			var startPoint = new Point(_mouseHandler.clickedX , _mouseHandler.clickedY);
			var endPoint = new Point(0, 0);
			add2.x = startPoint.x;
			add2.y = startPoint.y + 10;
			addChild(add2);
			add2.moveTo(startPoint, endPoint);
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
			var endPoint = new Point(0, 0);
			minus2.x = startPoint.x;
			minus2.y = startPoint.y + 10;
			addChild(minus2);
			minus2.moveTo(startPoint, endPoint);
			
		}
		
		//初始化水果栏图标与其个数栏显示
		private function initIcon():void
		{
			for (var i:uint = 1; i < _gamePage.vegetables.numChildren; i++)
			{
				_gamePage.vegetables.getChildAt(i).visible = false;
			}
			_gamePage.vegetables.carrot.visible = true;
			_gamePage.vegetables.score_carrot.visible = true;
			_gamePage.vegetables.ternip.visible = true;
			_gamePage.vegetables.score_ternip.visible = true;
			switch (gameProcess.level)
			{
				case 1: 
					_gamePage.vegetables.apple.visible = true;
					_gamePage.vegetables.score_apple.visible = true;
					break;
				case 2: 
					_gamePage.vegetables.cabbage.visible = true;
					_gamePage.vegetables.score_cabbage.visible = true;
					_gamePage.vegetables.pear.visible = true;
					_gamePage.vegetables.score_pear.visible = true;
					break;
				case 3: 
					_gamePage.vegetables.cabbage.visible = true;
					_gamePage.vegetables.score_cabbage.visible = true;
					_gamePage.vegetables.eggplant.visible = true;
					_gamePage.vegetables.score_eggplant.visible = true;
					_gamePage.vegetables.mango.visible = true;
					_gamePage.vegetables.score_mango.visible = true;
					break;
				case 4: 
					_gamePage.vegetables.cabbage.visible = true;
					_gamePage.vegetables.score_cabbage.visible = true;
					_gamePage.vegetables.eggplant.visible = true;
					_gamePage.vegetables.score_eggplant.visible = true;
					_gamePage.vegetables.pumpkids.visible = true;
					_gamePage.vegetables.score_pumpkids.visible = true;
					_gamePage.vegetables.watermelon.visible = true;
					_gamePage.vegetables.score_watermelon.visible = true;
					break;
			}
		}
	}

}