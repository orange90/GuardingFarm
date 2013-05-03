/************************************************
   这是一个游戏开始前经常用到的CG
 * 过程：“准备（一秒）-> 空白（0.2秒）-> 开始（一秒） 共2.2秒 （大概而已）
 * 用法：先实例化，在用的时候再调用函数playTips()即可开始。完成后需要处理其抛出的事件
 *author: Orange
 ***********************************************/
package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ReadyAndGoTips extends MovieClip
	{
		
		private const SCREEN_WIDTH:uint = 659;
		private const SCREEN_HEIGHT:uint = 466;
		
		private var repeat:uint = 120;
		private var timer:Timer = new Timer(20, repeat);
		private var readyMC:MovieClip = new ready();
		private var goMC:MovieClip = new go();
		private var initReadyMCWidth:Number = readyMC.width;
		private var initReadyMCHeight:Number = readyMC.height;
		private var initGoMCWidth:Number = goMC.width;
		private var initGoMCHeight:Number = goMC.height;
		
		public function ReadyAndGoTips()
		{
			readyMC.width = 0;
			readyMC.height = 0;
			goMC.width = 0;
			goMC.height = 0;
			
			timer.addEventListener(TimerEvent.TIMER, loadTips);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, setFinished);
		
		}
		
		public function playTips():void
		{
			addChild(readyMC);
			addChild(goMC);
			timer.start();
		}
		
		
		private function loadTips(e:TimerEvent):void
		{
			repeat--;
			if (repeat > 65)
			{
				readyMC.alpha -= 0.01;
				readyMC.width += initReadyMCWidth * 0.008;
				readyMC.height += initReadyMCHeight * 0.008;
				readyMC.x = (SCREEN_WIDTH - readyMC.width) / 2;
				readyMC.y = (SCREEN_HEIGHT - readyMC.height) / 2;
				goMC.alpha = 0;
			}
			else if (repeat > 55 && repeat < 65)
			{
				readyMC.alpha = 0;
				goMC.alpha = 0;
			}
			else
			{
				readyMC.alpha = 0;
				goMC.alpha += 0.01;
				goMC.width += initGoMCWidth * 0.008;
				goMC.height += initGoMCHeight * 0.008;
				goMC.x = (SCREEN_WIDTH - goMC.width) / 2;
				goMC.y = (SCREEN_HEIGHT - goMC.height) / 2;
			}
		}
		
		private function setFinished(e:TimerEvent):void
		{ 
			removeChild(readyMC);
			removeChild(goMC);
			dispatchEvent(new Event("ready_over"));
			//播放完发一个事件来触发关卡开始。。。。。。。。。。。。。。。。
		}
	
	}
}
