package code.app.mvc
{
	/**
	 * 控制器基类
	 * @author dom
	 */
	public class Controller extends Actor
	{
		/**
		 * 构造函数
		 */		
		public function Controller()
		{
			super();
		}
		
		/**
		 * 启动控制器
		 */		
		public function start():void
		{
			init();
			initListeners();
		}
		/**
		 * 初始化控制器
		 */		
		protected function init():void
		{
			
		}
		/**
		 * 初始化事件和命令监听
		 */		
		protected function initListeners():void
		{
			
		}
	}
}