package priv.yakiler.hf.interfaces
{
	import priv.yakiler.hf.mvc.command.CommandData;

	/**
	 * 命令接口。是消息广播后一系列指令执行的规范集合<br/>
	 * 所有命令都应该实现此接口以保证消息发出后能被正确处理，及撤销、重做等功能的正常调用。
	 * **/
	public interface ICommand
	{
		/**是否加入历史记录*/
		function get hasHistory():Boolean;
		function set hasHistory(value:Boolean):void;
		
		/**命令数据*/
		function get commandData():CommandData;
		
		/**命令数据中自定义的原始数据，请注意它应该是只读的。请不要随意修改它的任何值*/
		function get originData():*;
		/**命令数据中可能经过一系列修改的数据。<br/>
		 * 如果在命令中需要修改数据请使用newData，保证originData不变更有利于撤销和重做功能*/
		function get newData():*;
		
		/**注册命令时的消息名称（notificationName）*/
		function get name():String;
		
		/**命令的类型*/
		function get type():String;
		
		/**
		 * 初始化命令的数据。可覆盖执行数据初始化工作<br/>
		 * 如果是通过广播消息执行命令时会在调用命令构造函数后执行该方法。<br/>
		 * 如果手动执行命令需要初始化构造函数后手动调用
		 * */
		function initCommandData(commandData:CommandData):void;
		
		/**执行命令，所有command初始化完成后会自动调用此方法。*/
		function excute():void;
		
		/**重新执行命令，一般情况下可以调用<code>excute()方法</code>*/
		function redo():void;
		
		/**撤销命令，注意当前命令包含多条子命令时，一般需要倒序执行撤销*/
		function undo():void;
		
		/**将cmd转换为字符串输出*/
		function toString():String;
	}
}