package priv.yakiler.hf.interfaces
{
	import priv.yakiler.hf.mvc.command.CommandData;

	/**
	 * 消息接口，为消息的处理提供一个规范。
	 */
	public interface INotifier
	{
		/**
		 * 广播一条消息，然后会自动执行<code>registeCommand()</code>绑定的命令。
		 * @param notifacationName 消息名称。
		 * @param commandData 命令的数据
		 */ 
		function sendNotification( notificationName:String, commandData:CommandData ):void; 
		
		/**添加命令回调。消息广播后执行完相关命令，广播该通知。消息回调允许对同一个消息添加多个回调函数。
		 * @param notificationName 消息名称
		 * @param $listener 命令回调函数，命令执行完毕后会自动调用
		 * @param priority 优先级，数字越高优先级越高
		 * */
		function addCommandListener( notifacationName:String, $listener:Function, priority:int = 0 ):void;
	}
}