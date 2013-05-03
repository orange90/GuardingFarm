package com.event
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author orange
	 * 此类用于处理老鼠被点击后的事件，
	 * 包括：
	 * 	1.老鼠变成一只没拿东西的老鼠，
	 * 	2.水果飞到左上方，
	 * 	3.并且分数加相应值
	 * 需要用时在调用的页面new一个实例来用（此类非静态）
	 */
	public class MouseHandler extends MovieClip //不继承自MovieClip无法使用dispatchEvent方法。
	{
		private var _repeat:uint = 10;
		private var _timer:Timer;
		private var _currentPoint:Point;
		private var _endPoint:Point;
		private var _obj:Object = new Object();
		
		//记录被点击的地鼠的位置，用于飘出+2秒的图标
		private var _clickedX:Number;
		private var _clickedY:Number;
		
		private var mouseWithoutFruitArray:Array = new Array(); //用于存放被剥夺了老鼠的数组
		private var _setting:XML = XMLParser.getXMLdata()
		public function MouseHandler()
		{
			//什么也不做,此类的作用仅仅是调用下面的方法来处理点击事件
		}
		
		public function handleMouseClick(event:MouseEvent) //处理老鼠被点击的事件
    	{
			//各水果被点后应该飞往的地方
			var ternipPosition:Point = new Point(666 + 10, 9 + 10); //面板的位置加上其相对面板的位置
			var carrotPosition:Point = new Point(666 + 10, 9 + 50);
			var cabbagePosition:Point = new Point(666 + 10, 9 + 90);
			var eggplantPosition:Point = new Point(666 + 10, 9 + 130);
			var applePosition:Point = new Point(666 + 10, 9 + 90);
			var pearPosition:Point = new Point(666 + 10, 9 + 130);
			var mangoPosition:Point = new Point(666 + 10, 9 + 170);
			var pumpkidsPosition:Point = new Point(666 + 10, 9 + 170);
			var watermelonPosition:Point = new Point(666 + 10, 9 + 210);
			
			var startX:Number = event.target.x;
			var startY:Number = event.target.y;
			
			_currentPoint = new Point(startX, startY);
			
			
			var removeMouseTimer:Timer = new Timer(500, 1); //用于移除被剥夺了水果的老鼠
			removeMouseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeTheMouse)
			//以下是超长的选择过程。。。。。。。。。。。，极其不优雅，无法直视
			switch (event.target.toString())
			{
				case "[object MouseApple]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = applePosition;
					_obj = new Apple();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					gameProcess.total_score += int(_setting.fruitScore.apple);
					gameProcess.appleScore++;
					break;
				case "[object MousePear]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = pearPosition;
					_obj = new Pear();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					gameProcess.total_score += int(_setting.fruitScore.pear);
					gameProcess.pearScore++;
					break;
				case "[object MouseEggplant]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = eggplantPosition;
					_obj = new Eggplant();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					gameProcess.total_score += int(_setting.fruitScore.eggplant);
					gameProcess.eggplantScore++;
					break;
				case "[object MousePumpkids]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = pumpkidsPosition;
					_obj = new Pumpkids();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					gameProcess.total_score += int(_setting.fruitScore.pumpkids);
					gameProcess.pumpkidsScore++;
					break;
				case "[object MouseCabbage]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = cabbagePosition;
					_obj = new Cabbage();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					gameProcess.total_score += int(_setting.fruitScore.cabbage);
					gameProcess.cabbageScore++;
					break;
				case "[object MouseCarrot]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = carrotPosition;
					_obj = new Carrot();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					gameProcess.total_score += int(_setting.fruitScore.carrot);
					gameProcess.carrotScore++;
					break;
				case "[object MouseTernip]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = ternipPosition;
					_obj = new Ternip();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					trace(_setting.fruitScore.ternip);
					gameProcess.total_score += int(_setting.fruitScore.ternip);
					gameProcess.ternipScore++;
					break;
				case "[object MouseMango]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = mangoPosition;
					_obj = new Mango();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					gameProcess.total_score += int(_setting.fruitScore.mango);
					gameProcess.mangoScore++;
					break;
				case "[object MouseWatermelon]": 
					//原动画变成一只老鼠，手中的果飞往计分牌，同时gameProcess.Score加分
					_endPoint = watermelonPosition;
					_obj = new Watermelon();
					_obj.moveTo(_currentPoint, _endPoint)
					event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
					var mouse:Mouse = new Mouse(gameProcess.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
					event.target.parent.addChild(mouse);
					_obj.width *= 0.3;
					_obj.height *= 0.3;
					event.target.parent.addChild(_obj);
					mouseWithoutFruitArray.push(mouse);
					removeMouseTimer.start();
					gameProcess.total_score += int(_setting.fruitScore.watermelon);
					gameProcess.watermelonScore++;
					break;
					
					
			    case "[object Snake]":
				    event.target.flyAway();
					
					_clickedX = event.target.x;
					_clickedY = event.target.y;
					this.dispatchEvent(new Event("add2sec"));//将触发这些事：显示+2图标，并且总时间加2
					break;
				 case "[object Sister]":
					 event.target.cry();
					_clickedX = event.target.x;
					_clickedY = event.target.y;
					this.dispatchEvent(new Event("minus2sec"));//将触发这些事：显示+2图标，并且总时间加2
					break;
				    //无动作
				default: 
					break;
			}
		}
		
		public function get clickedX():Number
		{
			return _clickedX;
		}
		public function get clickedY():Number
		{
			return _clickedY;
		}
		
		
		private function removeTheMouse(event:TimerEvent):void
		{
			//var theRemovingMouse:Mouse = mouseWithoutFruitArray.shift()
			mouseWithoutFruitArray.shift().visible = false;
			//this.removeChild(theRemovingMouse);
		}
	
	}

}