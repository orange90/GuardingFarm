package game.event
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	//import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
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
		
		private var _mouseMap:Dictionary = new Dictionary();
		
		//记录被点击的地鼠的位置，用于飘出+2秒的图标
		private var _clickedX:Number;
		private var _clickedY:Number;
		
		private var mouseWithoutFruitArray:Array = new Array(); //用于存放被剥夺了老鼠的数组
		private var _setting:XML = XMLSaver.getXMLdata()
		
		public function MouseHandler()
		{
			//什么也不做,此类的作用仅仅是调用下面的方法来处理点击事件
			Mouse;
			MouseTernip;
		
		}
		
		public function handleMouseClick(event:MouseEvent) //处理老鼠被点击的事件
		{
			//各水果被点后应该飞往的地方
			var endPointMap:Dictionary = new Dictionary();
			endPointMap["ternip"] = new Point(666 + 10, 9 + 10);
			endPointMap["carrot"] = new Point(666 + 10, 9 + 50);
			endPointMap["cabbage"] = new Point(666 + 10, 9 + 90);
			endPointMap["eggplant"] = new Point(666 + 10, 9 + 130);
			endPointMap["apple"] = new Point(666 + 10, 9 + 90);
			endPointMap["pear"] = new Point(666 + 10, 9 + 130);
			endPointMap["mango"] = new Point(666 + 10, 9 + 170);
			endPointMap["pumpkids"] = new Point(666 + 10, 9 + 170);
			endPointMap["watermelon"] = new Point(666 + 10, 9 + 210);
			
			var startX:Number = event.target.x;
			var startY:Number = event.target.y;
			
			_currentPoint = new Point(startX, startY);
			var removeMouseTimer:Timer = new Timer(500, 1); //用于移除被剥夺了水果的老鼠
			removeMouseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeTheMouse)
		
			if (event.target is Mouse && getQualifiedClassName(event.target) != "Mouse" && !(event.target is Snake) && !(event.target is Sister))
			{
				//取得点击的老鼠拿着的水果是啥，例如 MouseApple拿着Apple
				var mouseFruitType:String = getQualifiedClassName(event.target).slice(5, getQualifiedClassName(event.target).length);
				
				_endPoint = endPointMap[mouseFruitType.toLowerCase()];
				
				var FruitClass:Class = getDefinitionByName(mouseFruitType) as Class;
				_obj = new FruitClass();
				TweenLite.from(_obj, 1, {x: _currentPoint.x, y: _currentPoint.y, ease: Back.easeOut, visible: false});
				TweenLite.to(_obj, 1, {x: _endPoint.x, y: _endPoint.y, ease: Back.easeOut, onComplete: removeFruit, onCompleteParams: [_obj]});
				event.target.visible = false; //隐藏被点击的(带水果）老鼠（过期后会自动被remove掉）
				var mouse:Mouse = new Mouse(HolePosition.holes[event.target.inWhichHole]) //放出新的老鼠（没拿水果的）
				event.target.parent.addChild(mouse);
				_obj.width *= 0.3;
				_obj.height *= 0.3;
				event.target.parent.addChild(_obj);
				mouseWithoutFruitArray.push(mouse);
				removeMouseTimer.start();
			}
			
			function removeFruit(fruit:Fruit):void //方法内的方法
			{
				fruit.visible = false;
				if (fruit != null && event.target.parent != null)
				{
					event.target.parent.removeChild(fruit);
				}
			}
			
				switch (getQualifiedClassName(event.target))
				{
					//貌似这里换成表驱动并不省很多。
					case "MouseApple": 
						gameProcess.total_score += int(_setting.fruitScore.apple);
						gameProcess.appleScore++;
						break;
					case "MouseTernip": 
						gameProcess.total_score += int(_setting.fruitScore.ternip);
						gameProcess.ternipScore++;
						break;
					case "MouseCarrot": 
						gameProcess.total_score += int(_setting.fruitScore.carrot);
						gameProcess.carrotScore++;
						break;
					case "MouseCabbage": 
						gameProcess.total_score += int(_setting.fruitScore.cabbage);
						gameProcess.cabbageScore++;
						break;
					case "MouseEggplant": 
						gameProcess.total_score += int(_setting.fruitScore.eggplant);
						gameProcess.eggplantScore++;
						break;
					case "MousePear": 
						gameProcess.total_score += int(_setting.fruitScore.pear);
						gameProcess.pearScore++;
						break;
					case "MouseMango": 
						gameProcess.total_score += int(_setting.fruitScore.mango);
						gameProcess.mangoScore++;
						break;
					case "MousePumpkids": 
						gameProcess.total_score += int(_setting.fruitScore.pumpkids);
						gameProcess.pumpkidsScore++;
						break;
					case "MouseWatermelon": 
						gameProcess.total_score += int(_setting.fruitScore.watermelon);
						gameProcess.watermelonScore++;
						break;
					case "Snake": 
						trace("i am snake");
						event.target.flyAway();
						_clickedX = event.target.x;
						_clickedY = event.target.y;
						this.dispatchEvent(new Event("add2sec")); //将触发这些事：显示+2图标，并且总时间加2
						break;
					case "Sister": 
						event.target.cry();
						_clickedX = event.target.x;
						_clickedY = event.target.y;
						this.dispatchEvent(new Event("minus2sec")); //将触发这些事：显示+2图标，并且总时间加2
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