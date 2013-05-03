package com.pages 
{
	/**
	 * ...
	 * @author orange
	 */
	public class WinPage extends basePage
	{
		private var _win:Win = new Win();
		private var _submit:SubmitRecordRes = new SubmitRecordRes();
		public function WinPage() 
		{
			this.addChild(_win);
			_win.total_score.text = gameProcess.total_score.toString();
			_submit.x = (_win.width - _submit.width) / 2;
			_submit.y = (_win.height - _submit.height) / 2;
			this.addChild(_submit);
			//提交到服务器，重写xml
			//_submit.your_name
		}
		
		
	}

}