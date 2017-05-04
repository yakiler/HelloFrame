package priv.yakiler.hf.interfaces
{
	import flash.display.DisplayObject;

	/**
	 * 控制器应该拥有的一些基本功能集合，所有自定义控制器都应该实现此接口。<br/>
	 * 通常会包含数据模型，视图，添加事件，注册命令，添加命令侦听和控制器启动入口<code>start()</code>
	 * */
	public interface IController
	{
		/**
		 * 模块的数据模型，每个视图模块应对应唯一数据模型。<br/>
		 * 注意：如果视图包含多种数据实体应统一为一个数据模型
		 * */
		function get model():IModel;
		
		/**模块的对应视图*/
		function get view():DisplayObject;
		
		/**数据初始化，应该为每个数据实体添加一个初始化方法，并从这里调用*/
		function initModel( model:IModel = null ):void;
		
		/**视图初始化，应该为每个视图添加一个初始化方法，并从这里调用*/
		function initView( view:DisplayObject = null ):void;
		
		/**添加事件侦听器的地方，所有事件侦听都应该集中写在这里*/
		function addEventListeners():void;
		
		/**
		 * 命令注册，所有command命令都需要注册方可使用sendNotifacation()<br/>
		 * @param notificationName 消息名称
		 * @param commandClass 命令类名
		 * */
		function registerCommand( notificationName:String, commandClass:Class ):void;
		
		/**注册命令。以便在后续使用<code>sendNotification()</code>来广播消息**/
		function reigsterCommands():void;
		
		/**添加命令侦听的地方，所有命令侦听都应该集中写在这里*/
		function addCommands():void;
		
		/**控制器启动函数。只有手动调用<code>start()</code>才能启动控制器*/
		function start():void;
	}
}