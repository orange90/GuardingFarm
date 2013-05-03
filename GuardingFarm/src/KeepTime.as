package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.getTimer;
	import com.event.*;
	/**
	 * ...
	 * @author orange
	 * 这是一个自定义的计时器，用于显示在游戏关卡的左上方
	 */
	public class KeepTime extends MovieClip
	{
		private var _keepTimeRes:KeepTimeRes = new KeepTimeRes();//读取时钟外观资源
		private var _timeLength:uint;
		private var _timeSwitch:Boolean = false;//在renewTIme()里面使用，用于判断是否可以开始更新时间值
		private var startTime:uint;
		private var _timeGap:uint;
		
		public function KeepTime()
		{
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, handleComplete);
			loader.load(new URLRequest("gameSetting.xml"));
		
		}
		
		private function handleComplete(event:Event):void
		{ //从已载入的xml文件里面读取关卡时间值
			
			var settingFile:XML = new XML(event.target.data);
			var thisLevelSetting:XML = new XML(settingFile.level.(@id == gameProcess.level));
			_timeLength = int(thisLevelSetting.time) * 1000; //转成毫秒计时		
		}
		
		public function startKeepTime():void
		{
			addChild(_keepTimeRes);
			_keepTimeRes.timeText.text = _timeLength / 1000 + "秒";
			_timeSwitch = true;
			addEventListener(Event.ENTER_FRAME, renewTime)
			startTime = getTimer();
		}
		
		public function stopKeepTime():void
		{
			_timeSwitch = false;
			removeEventListener(Event.ENTER_FRAME, renewTime)
		}
		
		public function add2Sec():void
		{
			_timeLength += 2000;
		}
		
		public function minus2Sec():void
		{
			_timeLength -= 2000;
		}
		
		private function renewTime(event:Event):void
		{
			if (_timeSwitch == false)
				return;
			_timeGap = getTimer() - startTime;
			if (timeGap > _timeLength)
			{
				_keepTimeRes.timeText.text = "Time Up!";
				endLevel();
			}
			else
			{
				var remainTime:uint = _timeLength - timeGap;
				_keepTimeRes.timeText.text = Math.floor(remainTime / 1000).toString() + ":" + Math.floor((remainTime % 1000) / 10);
			}
		}
		private function endLevel():void
		{
			_timeSwitch = false;
			removeEventListener(Event.ENTER_FRAME, renewTime);
			stopKeepTime();
			dispatchEvent(new Event(GameEvent.TIME_OVER));//时间到了，发出事件让其他部分响应
		}
		public function get timeGap():uint //取得用了多少时间
		{
			return _timeGap;
		}
		public function get timeLength():uint //取得总时间的多少
		{
			return _timeLength;
		}
	}
}