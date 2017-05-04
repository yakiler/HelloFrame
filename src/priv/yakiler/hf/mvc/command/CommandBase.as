package priv.yakiler.hf.mvc.command
{
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.LogLogger;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import priv.yakiler.hf.interfaces.ICommand;
	import priv.yakiler.hf.interfaces.INotifier;
	import priv.yakiler.hf.namespaces.hf;
	
	/**
	 * 命令基类，不应该实例化，而是继承并实现它的方法。
	 * */
	public class CommandBase implements ICommand, INotifier
	{
		// ---------------------------------------------------------------------------------
		//
		//		构造函数
		//
		// ---------------------------------------------------------------------------------
		
		public function CommandBase()
		{
			
		}
		
		
		
		// ---------------------------------------------------------------------------------
		//
		//		属性定义区
		//
		// ---------------------------------------------------------------------------------
		
		/**命令控制器，负责调度所有命令及撤销重做历史*/
		hf var cm:CommandManager = CommandManager.instance;
		
		
		
		// ---------------------------------------------------------------------------------
		//
		//		函数定义区
		//
		// ---------------------------------------------------------------------------------
		
		/**初始化命令时调用的方法，可以覆盖做些初始化工作*/
		public function initCommandData( commandData:CommandData ):void
		{
			this._commandData = commandData;
		}
		
		/**执行命令，所有command初始化完成后会自动调用此方法。*/
		public function excute():void
		{
		}
		
		/**重新执行命令，一般情况下可以调用<code>excute()方法</code>*/
		public function redo():void
		{
		}
		
		/**撤销命令，注意当前命令包含多条子命令时，一般需要倒序执行撤销*/
		public function undo():void
		{
		}
		
		/**发送一条命令*/
		public function sendNotification( notifacationName:String, commandData:CommandData ):void
		{
			hf::cm.sendNotification( notifacationName, commandData );
		}
		
		/**添加命令回调。消息广播后执行完相关命令，广播该通知。消息回调允许对同一个消息添加多个回调函数。
		 * @param notificationName 消息名称
		 * @param $listener 命令回调函数，命令执行完毕后会自动调用
		 * @param priority 优先级，数字越高优先级越高
		 * */
		public function addCommandListener( notifacationName:String, $listener:Function, priority:int = 0 ):void
		{
			hf::cm.addCommandListener( notifacationName, $listener, priority );
		}
		
		/**格式化命令输出*/
		public function toString():String
		{
			var	clazz:String = getQualifiedClassName(this);
			
			return 'Command:' + clazz + ' ++++++ type:' + type + ' ++++++ name:' + name;
		}
		
		
		
		// ---------------------------------------------------------------------------------
		//
		//		getter and setter
		//
		// ---------------------------------------------------------------------------------
		
		/**命令携带的数据*/
		protected var _commandData:CommandData;
		/**命令携带的数据*/
		public function get commandData():CommandData
		{
			return _commandData;
		}
		
		/**命令数据中自定义的原始数据，请注意它应该是只读的。请不要随意修改它的任何值*/
		public function get originData():*
		{
			return commandData ? commandData.originData : null;
		}
		/**命令数据中可能经过一系列修改的数据。<br/>
		 * 如果在命令中需要修改数据请使用newData，保证originData不变更有利于撤销和重做功能*/
		public function get newData():*
		{
			return commandData ?  commandData.newData : null;
		}
		/**注册命令时的消息名称（notificationName）*/
		public function get name():String
		{
			return commandData ? commandData.name : null;
		}
		/**命令的类型*/
		public function get type():String
		{
			return commandData ? commandData.type : null;
		}
		
		private var _hasHistory:Boolean = true;
		
		/**是否添加到历史记录(即是否可撤销或重做)，如果不希望加入历史可以在初始化时将它置为false*/
		public function get hasHistory():Boolean
		{
			return _hasHistory;
		}
		/**
		 * @private
		 */
		public function set hasHistory(value:Boolean):void
		{
			_hasHistory = value;
		}
	}
}