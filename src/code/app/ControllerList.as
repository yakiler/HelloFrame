package code.app
{
	import code.module.sample.SampleController;

	/**
	 * 控制器列表
	 * @author dom
	 */
	public class ControllerList
	{
		/**
		 * 构造函数
		 */		
		public function ControllerList()
		{
		}

		private var sampleController:SampleController = new SampleController();
		/**
		 * 启动所有控制器
		 */		
		public function start():void
		{
			sampleController.start();
		}
	}
}