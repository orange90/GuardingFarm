package com.pages 
{
	/**
	 * ...
	 * @author orange
	 */
	public class FailPage extends basePage
	{
		private var _fail:Fail = new Fail();
		private var _submit:SubmitRecordRes = new SubmitRecordRes();
		public function FailPage() 
		{
			this.addChild(_fail);
			_fail.total_score.text = gameProcess.total_score.toString();
			_submit.x = (_fail.width - _submit.width) / 2;
			_submit.y = (_fail.height - _submit.height) / 2;
			this.addChild(_submit);
		}
		
	}

}