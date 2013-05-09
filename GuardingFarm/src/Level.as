/***************************************************************
 *里面有多个switch(_currentLevel)，是为了让每个阶段的赋值更清晰。
 *如果一个switch(_currentLevel)的画，一段程序会变得太长，不好读
 ****************************************************************/

package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	
	public class Level extends MovieClip
	{
		//关卡预设值
		private var _currentLevel:uint; //当前关卡
		private var _destScore:uint; //目标分值
		private var _maxScore:uint; //最大分值
		private var _time:Number; //时间
		private var _frequency:Number; //出现频率 x秒/次
		private var _stayTime:Number; //停留时间
		
		//记录下上次被移除的老鼠（或毒蛇)的位置，
		//用于毒蛇未点击时减两秒的那个图标可以有个起飞的起点
		private var _removedMouseX:Number;
		private var _removedMouseY:Number;
		
		//各水果出现频率(后续会在不同的关卡给不同的水果赋予一定的出现几率，未赋值的默认为零，即不出现。
		private var _ternipRate:Number = 0;
		private var _carrotRate:Number = 0;
		private var _appleRate:Number = 0;
		private var _cabbageRate:Number = 0;
		private var _pearRate:Number = 0;
		private var _eggplantRate:Number = 0;
		private var _mangoRate:Number = 0;
		private var _pumpkidsRate:Number = 0;
		private var _watermelonRate:Number = 0;
		private var _snakeRate:Number = 0;
		private var _sisterRate:Number = 0;
		
		private var _settingFile:XML; //配置文件
		private var _thisLevelSetting:XML; //配置（从配置文件读取出来）
		private var _mouseArray:Array = new Array(); //在舞台上的老鼠
		
		private var timer:Timer //间隔出现老鼠
		
		private var levelTimer:KeepTime; //每关计时器-----------------------------------------
		
		private var triggered:Boolean = false; //保证给新出现的老鼠的概率只赋值一次
		private var usedHole:Vector.<uint> = new Vector.<uint>;
		private var unusedHole:Vector.<uint> = new <uint>[0, 1, 2, 3, 4, 5];
		//private var readyOverSwitch:Boolean = true; //保证readyOver函数赋值的部分只执行一次
		private var _sisterIsHit:Boolean = false;
		private var _snakeMadeMess:Boolean = false;
		
		public function Level()
		{
			
			//初始化各洞，让其处于非占用状态
			for (var i:uint = 0; i < HolePosition.holes.length; i++)
			{
				HolePosition.holes[i].is_taken = false;
			}
			_currentLevel = gameProcess.level; //在静态类gameProcess里面载入当前关卡
			_settingFile = XMLSaver.getXMLdata();
			
			initLevel(); //初始化关卡数据
			enterLevel(); //然后进入游戏关卡
		}
		
		private function initLevel():void
		{
			_thisLevelSetting = new XML(_settingFile.level.(@id == _currentLevel));
			//初始化各水果出现几率(若xml文件内无此水果，则相应的出现概率自动为零）
			_ternipRate = _thisLevelSetting.ternipRate;
			_carrotRate = _thisLevelSetting.carrotRate;
			_cabbageRate = _thisLevelSetting.cabbageRate;
			_eggplantRate = _thisLevelSetting.eggplantRate;
			_pumpkidsRate = _thisLevelSetting.pumpkidsRate;
			_snakeRate = _thisLevelSetting.snakeRate;
			_sisterRate = _thisLevelSetting.sisterRate;
			
			_destScore = _thisLevelSetting.destScore;
			_maxScore = _thisLevelSetting.maxScore;
			_time = _thisLevelSetting.time;
			_frequency = _thisLevelSetting.frequency;
			_stayTime = _thisLevelSetting.stayTime;
		
		}
		
		private function enterLevel():void
		{
			//根据关卡不同设置不同的计时器
			timer = new Timer(_thisLevelSetting.frequency * 1000, 0); //此时timer的作用仅仅是出现老鼠    
			timer.addEventListener(TimerEvent.TIMER, showMouse); //出现老鼠
		}
		
		public function startLevel():void
		{
			timer.start();
		}
		
		public function stopLevel():void
		{
			timer.stop();
			removeEventListener(Event.ENTER_FRAME, removeExpiredMouse);
			dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
		}
		
		private function showMouse(e:TimerEvent):void
		{ //每个间隔出现一个老鼠（并同时检测所存在的老鼠是否超过了显示时间）
			const totalRate:Number = 1; //所有类型老鼠出现概率总和（当然是1啦！）
			var randomPosition:Number = Math.random();
			var randomHole:uint = Math.floor(Math.random() * 6);
			
			randomHole = popRandomHoleIndex();
			checkScore(); //检查是否达到新老鼠出现条件
			HolePosition.holes[randomHole].is_taken = true; //然后把此洞占用
			addEventListener(Event.ENTER_FRAME, removeExpiredMouse);
			
			//根据概率和当前关卡出现地鼠////////////////////////
			//本想用Dictionary类来存储各关的，但是需要建立多个dictionary才能实现，比现在还复杂，故不改写此段
			switch (_currentLevel)
			{
				case 1: 
					if (randomPosition < _ternipRate)
					{
						_mouseArray.push(new MouseTernip(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate)
					{
						_mouseArray.push(new MouseCarrot(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else
					{
						_mouseArray.push(new MouseApple(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					break;
				
				case 2: 
					if (randomPosition < _ternipRate)
					{
						_mouseArray.push(new MouseTernip(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate)
					{
						_mouseArray.push(new MouseCarrot(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate + _cabbageRate)
					{
						_mouseArray.push(new MouseCabbage(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else
					{
						_mouseArray.push(new MousePear(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					break;
				
				case 3: 
					if (randomPosition < _ternipRate)
					{
						_mouseArray.push(new MouseTernip(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate)
					{
						_mouseArray.push(new MouseCarrot(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate + _cabbageRate)
					{
						_mouseArray.push(new MouseCabbage(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate + _cabbageRate + _eggplantRate)
					{
						_mouseArray.push(new MouseEggplant(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate + _cabbageRate + _eggplantRate + _snakeRate)
					{
						_mouseArray.push(new Snake(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else
					{
						_mouseArray.push(new MouseMango(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					break;
				
				case 4: 
					if (randomPosition < _ternipRate)
					{
						_mouseArray.push(new MouseTernip(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate)
					{
						_mouseArray.push(new MouseCarrot(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate + _cabbageRate)
					{
						_mouseArray.push(new MouseCabbage(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate + _cabbageRate + _eggplantRate)
					{
						_mouseArray.push(new MouseEggplant(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate + _cabbageRate + _eggplantRate + _pumpkidsRate)
					{
						_mouseArray.push(new MousePumpkids(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else if (randomPosition < _ternipRate + _carrotRate + _cabbageRate + _eggplantRate + _pumpkidsRate + _sisterRate)
					{
						_mouseArray.push(new Sister(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					else
					{
						_mouseArray.push(new MouseWatermelon(HolePosition.holes[randomHole]));
						this.addChild(_mouseArray[_mouseArray.length - 1]);
					}
					break;
			}
		}
		
		private function popRandomHoleIndex():uint //随机一个洞让地鼠出现
		{
			if (unusedHole.length == 0)
				return 0;
			var randomIndex:uint = Math.floor(unusedHole.length * Math.random());
			var theHoleIndex:uint = uint(unusedHole.splice(randomIndex, 1));
			return theHoleIndex;
		}
		
		private function removeExpiredMouse(e:Event):void //移除过时的老鼠
		{
			if (_mouseArray.length == 0)
				return;
			for (var i:uint = 0; i < _mouseArray.length; i++)
			{
				_mouseArray[i].stayTime = getTimer() - _mouseArray[i].addTime;
				if (_mouseArray[i].stayTime > int(_thisLevelSetting.stayTime) * 1000)
				{ //转为毫秒
					
					if (_mouseArray[i] is Snake && _mouseArray[i].visible == true)
						//因为被点击过的地鼠（或蛇）都是设成了visible = false，所以这里可以通过其visible是否为true来判断是否被点过。
					{
						_mouseArray[i].makeAMess(); //此函数已经顺带可以把毒蛇从舞台隐藏（虽非移除，但是毒蛇出现的机会少，所以不移除也不会占用很多资源）；
						_removedMouseX = _mouseArray[i].x;
						_removedMouseY = _mouseArray[i].y;
						this.dispatchEvent(new Event("minus2sec"));
					}
					else
					{
						this.removeChild(_mouseArray[i]);
					}
					
					HolePosition.holes[_mouseArray[i].inWhichHole].is_taken = false;
					unusedHole.push(_mouseArray[i].inWhichHole);
					
					_mouseArray.splice(i, 1);
					
				}
			}
		}
		
		private function checkScore():void
		{ //检查分数是否达到新老鼠出现条件
			if (triggered)
				return;
			switch (_currentLevel)
			{ //各关出现新地鼠的条件
				case 1: 
					if (gameProcess.total_score > _thisLevelSetting.addition.triggerScore)
					{
						triggered = true;
						_appleRate = _thisLevelSetting.addition.appleRate;
						_ternipRate -= _appleRate;
					}
					break;
				case 2: 
					if (gameProcess.total_score > _thisLevelSetting.addition.triggerScore)
					{
						triggered = true;
						_pearRate = _thisLevelSetting.addition.pearRate;
						_ternipRate -= _pearRate;
					}
					break;
				case 3: 
					if (gameProcess.total_score > _thisLevelSetting.addition.triggerScore)
					{
						triggered = true;
						_mangoRate = _thisLevelSetting.addition.mangoRate;
						_ternipRate -= _mangoRate;
					}
					break;
				case 4: 
					if (gameProcess.total_score > _thisLevelSetting.addition.triggerScore /*&& _sisterIsHit == false*/)
					{ //还得未点击过地鼠妹妹
						triggered = true;
						_watermelonRate = _thisLevelSetting.addition.watermelonRate;
						_ternipRate -= _watermelonRate;
					}
					break;
			}
		}
		
		public function get removedMouseX():Number
		{
			return _removedMouseX;
		}
		
		public function get removedMouseY():Number
		{
			return _removedMouseY;
		}
		
		public function set sisterIsHit(hit:Boolean):void
		{
			_sisterIsHit = hit;
		}
	
	}
}
