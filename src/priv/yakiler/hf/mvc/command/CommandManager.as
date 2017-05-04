package priv.yakiler.hf.mvc.command
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	import mx.core.FlexGlobals;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	
	import priv.yakiler.hf.dataStructure.Queue;
	import priv.yakiler.hf.dataStructure.Stack;
	import priv.yakiler.hf.event.HFEvent;
	import priv.yakiler.hf.interfaces.ICommand;
	import priv.yakiler.hf.namespaces.hf;
	import priv.yakiler.hf.uitl.LogUtil;

	/**
	 * 命令管理器：包含所有命令的管控和执行，同时记录命令的执行顺序和撤销情况。
	 * */
	public class CommandManager
	{
		// ---------------------------------------------------------------------------------
		//
		//		属性
		//
		// ---------------------------------------------------------------------------------
		/**命令回调函数,key是命令名称，value是监听函数*/
		protected var commandListeners:Object = {};
		/**记录可能撤销的消息，加入commandQueue的消息都需要加入此队列*/
		protected var undoStack:Stack = new Stack();
		/**记录可能重做的消息，执行<code>undo()</code>后都需要加入此队列*/
		protected var redoStack:Stack = new Stack();
		/**发送消息的队列，按顺序存储所有通过<code>sendNotifaction()</code>广播的消息*/
		protected var commandQueue:Queue = new Queue();
		/**存储所有消息注册信息。key是消息名称，value是命令Class*/
		protected var commands:Object  = {};
		/**存储所有的消息。key是command实例，value是消息名称*/
		protected var notifications:Dictionary = new Dictionary;
		/**日志记录实例，所有输出日志都应该使用logger记录信息*/
		protected var logger:LogLogger = LogUtil.getLogger("commandManagerLogLogger");
		
		
		// ---------------------------------------------------------------------------------
		//
		//		构造函数
		//
		// ---------------------------------------------------------------------------------
		/**
		 * 构造函数
		 * */
		public function CommandManager()
		{
			if( !commandQueue.hasEventListener(Queue.INTO_QUEUE) )
			{
				commandQueue.addEventListener(Queue.INTO_QUEUE, notifacationIntoQueueHandle);
			}
		}
		
		
		// ---------------------------------------------------------------------------------
		//
		//		函数
		//
		// ---------------------------------------------------------------------------------
		/**命令重做回掉函数*/
		public function redoHandle():void
		{
			var cmd:ICommand = redoStack.outStack();
			if( cmd )
			{
				if( cmd.hasHistory )
				{
					undoStack.intoStack(cmd);
				}
				cmd.redo();
			}
		}
		
		/**命令撤销的回掉函数*/
		public function undoHandle():void
		{
			var cmd:ICommand = undoStack.outStack();
			if( cmd )
			{
				if( cmd.hasHistory )
				{
					redoStack.intoStack(cmd);
				}
				cmd.undo();
			}
		} 
		
		/**
		 * 当有命令被执行时，处理命令的撤销和执行
		 * */
		private function notifacationIntoQueueHandle( e:Event ):void
		{
			var cmd:ICommand = commandQueue.outQueue();
			if( cmd )
			{
				if( cmd.hasHistory )
				{
					undoStack.intoStack( cmd );
				}
				excute( cmd );
				redoStack.removeAll();
			}
		}
		
		/**广播一条消息，此方法会自动执行通过<code>registerCommand()</code>注册的命令<br/>
		 * 注意：不希望被加入历史记录的消息可以通过设置命令的hasHistory为false或者像这样调用命令<br>
		 * <code>
		 *		var command:ICommand = new CommandClass();<br/>
		 * 		command.initCommandData( commandData );<br/>
		 * 		command.excute();	
		 * </code>                               
		 * */
		public function sendNotification( notifacationName:String, commandData:CommandData ):void
		{
			if( notifacationName && commandData )
			{
				commandData.hf::name = notifacationName;
				var clazz:Class = getCommandClass( notifacationName );
				if( !clazz )
				{
					logger.log(LogEventLevel.DEBUG, "sendNotification():该消息"+notifacationName+"未通过registerCommand()注册命令");
					return;
				}
				var cmd:ICommand = new clazz();
				cmd.initCommandData(commandData);
				notifications[ cmd ] = notifacationName;
				commandQueue.intoQueue( cmd );
			}
		}
		
		/**
		 * 添加一个命令监听，当某个命令完成时，自动执行回调函数。
		 * @param priority 优先级，数字越大优先级越高。
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
			if( notifacationName && $listener != null )
			{
				if( !commandListeners[ notifacationName ] )
				{
					commandListeners[ notifacationName ] = [];
				}
				(commandListeners[ notifacationName ] as Array).push({ "listener":$listener, "priority":priority });
				(commandListeners[ notifacationName ] as Array).sortOn("priority", [Array.DESCENDING]);
			}
		}
		
		/**执行命令，可根据具体需求覆盖。但一般不推荐这么做。*/
		protected function excute( cmd:ICommand ):void
		{
			if( cmd )
			{
				cmd.excute();
				excuteCommandListener( cmd );
			}
		}
		
		/**执行命令回掉函数*/
		protected function excuteCommandListener( cmd:ICommand ):void
		{
			if( cmd )
			{
				var notificationName:String = notifications[ cmd ] ;
				if( notificationName )
				{
					var listeners:Array = commandListeners[ notificationName ];
					if( listeners && listeners.length )
					{
						for (var i:int = 0; i < listeners.length; i++) 
						{
							var foo:Object = listeners[i];
							var listener:Function = foo.listener as Function;
							listener.call( null, cmd.commandData );
						}
					}
				}else
				{
					logger.error("excuteCommandListener():未能根据命令找到消息名称，请确认是否通过registerCommand()注册。\n" + cmd.toString());
				}
			}
		}
		
		/**注册消息，然后才可以通过<code>sendNotiacation()</code>执行*/
		public function registerCommand( notificationName:String, commandClazz:Class ):void
		{
			if( notificationName && commandClazz )
			{
				if( commands[ notificationName ] )
				{
					throw new Error("此消息已被注册");
				}
				commands[ notificationName ] = commandClazz;
			}
		}
		/**解除通过<code>registerCommand()</code>注册的消息*/
		public function unRegisterCommand( notifacationName:String ):void
		{
			if( notifacationName && commands[ notifacationName ] )
			{
				delete commands[ notifacationName ];
			}
		}
		/**获取消息注册时的命令Class，如果返回Null说明未注册*/
		public function getCommandClass( notifacationName:String ):Class
		{
			return commands[ notifacationName ] as Class || null;
		}
		/**检测消息是否被注册*/
		public function hasCommand( notifacationName:String ):Boolean
		{
			return !!commands[ notifacationName ];
		}
		
		
		// ---------------------------------------------------------------------------------
		//
		//		单例实现
		//
		// ---------------------------------------------------------------------------------
		private static const _instance:CommandManager = new CommandManager;
		
		public static function get instance():CommandManager
		{
			return _instance;
		}
		
		
		// ---------------------------------------------------------------------------------
		//
		//		getter and  setter
		//
		// ---------------------------------------------------------------------------------
		
		/**舞台引用*/
		public function get stage():Stage
		{
			return (FlexGlobals.topLevelApplication as DisplayObject).stage || null;
		}
		
		/**是否可以撤销*/
		public function get canUndo():Boolean
		{
			return undoStack.length > 0;
		}
		
		/**是否可以重做*/
		public function get canRedo():Boolean
		{
			return redoStack.length > 0;
		}
	}
}