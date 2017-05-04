package priv.yakiler.hf.mvc.controller
{
	import flash.display.DisplayObject;
	
	import priv.yakiler.hf.interfaces.IController;
	import priv.yakiler.hf.interfaces.IModel;
	import priv.yakiler.hf.interfaces.INotifier;
	import priv.yakiler.hf.interfaces.IValueObject;
	import priv.yakiler.hf.mvc.command.CommandData;
	import priv.yakiler.hf.mvc.command.CommandManager;
	import priv.yakiler.hf.namespaces.hf;
	
	/**
	 * 控制器基类。不能直接实例化，而是通过继承实现。<br/>
	 * 注意覆盖相关方法，应该依照规范将相关功能代码放于合适的位置。比如：<br/>
	 * 添加事件侦听器应在<code>addEventListeners()</code><br/>
	 * 添加命令侦听器应在<code>addCommands()</code><br/>
	 * 消息注册应统一在<code>reigsterCommands()</code>这里完成<br/>
	 * 对于视图的初始化应在<code>initView()</code>
	 * 对于数据模型的初始化应在<code>initModel()</code><br/>
	 * 最后通过<code>start()</code>方法启动
	 * */
	public class ControllerBase implements IController, INotifier
	{
		/**命令管理器*/
		hf var cm:CommandManager = CommandManager.instance;
		protected var _model:IModel;
		protected var _view:DisplayObject;
		public function ControllerBase()
		{
		}
		
		/**数据初始化，应该为每个数据实体添加一个初始化方法，并从这里调用*/
		public function initModel( model:IModel = null ):void
		{
			if( model )
			{
				model.initModel();
				this._model = model;
			}
		}
		
		/**视图初始化，应该为每个视图添加一个初始化方法，并从这里调用*/
		public function initView( view:DisplayObject = null ):void
		{
			if( view )
			{
				this._view = view;
			}
		}
		
		/**添加事件侦听器的地方，所有事件侦听都应该集中写在这里*/
		public function addEventListeners():void
		{
		}
		
		/**添加命令侦听的地方，所有命令侦听都应该集中写在这里*/
		public function addCommands():void
		{
			
		}
		
		/**
		 * 控制器启动函数。只有手动调用<code>start()</code>才能启动控制器<br/>
		 * 它默认会依次调用<code>reigsterCommands(),initModel(),initView(),addEventListeners(),addCommands()</code>
		 * */
		public function start():void
		{
			reigsterCommands();
			initModel();
			initView();
			addEventListeners();
			addCommands();
		}
		
		/**注册命令。以便在后续使用<code>sendNotification()</code>来广播消息**/
		public function reigsterCommands():void
		{
		}
		
		/**
		 * 命令注册，所有command命令都需要注册方可使用sendNotifacation()<br/>
		 * @param notificationName 消息名称
		 * @param commandClass 命令类名
		 * */
		public function registerCommand( notificationName:String, commandClazz:Class ):void
		{
			hf::cm.registerCommand( notificationName, commandClazz );
		}
		
		/**
		 * 广播一条消息
		 * @param notificationName 消息名称
		 * @param commandData 命令携带的数据
		 */ 					
		public function sendNotification( notificationName:String, commandData:CommandData ):void
		{
			hf::cm.sendNotification( notificationName, commandData );
		}
		
		/**
		 * @protected
		 * 添加命令回调。消息广播后执行完相关命令，广播该通知。<br/>
		 * 应该避免在非子类的地方使用。
		 * @param $listener 命令完成后需要执行的回掉函数；它看起来应该这样<br/>
		 * <code>
		 *&nbsp;&nbsp;&nbsp;&nbsp;function callbackFun( commandData:CommandData ):void<br/>
		 *&nbsp;&nbsp;&nbsp;&nbsp;{<br/>
		 *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;// you code<br/>
 		 *&nbsp;&nbsp;&nbsp;&nbsp;}<br/>
		 * </code>
		 * */
		public function addCommandListener( notifacationName:String, $listener:Function, priority:int = 0 ):void
		{
			hf::cm.addCommandListener( notifacationName, $listener, priority );
		}
		
		/**命令撤销*/
		public function undo():void
		{
			hf::cm.undoHandle();
		}
		
		/**命令重做*/
		public function redo():void
		{
			hf::cm.redoHandle();
		}
		
		/**是否允许撤销*/
		public function get canUndo():Boolean
		{
			var foo:Boolean;
			var b:* = hf::cm.canUndo;
			foo = b;
			return foo;
		}
		/**是否允许重做*/
		public function get canRedo():Boolean
		{
			var foo:Boolean;
			var b:* = hf::cm.canRedo;
			foo = b;
			return foo;
		}
		
		// -----------------------------------------------------------------
		//		getter and setter 
		// -----------------------------------------------------------------
		
		/**
		 * 模块的数据模型，每个视图模块应对应唯一数据模型。<br/>
		 * 注意：如果视图包含多种数据实体应统一为一个数据模型
		 * */
		public function get model():IModel
		{
			return _model;
		}
		
		/**模块的顶级视图*/
		public function get view():DisplayObject
		{
			return _view;
		}
	}
}