package priv.yakiler.hf.interfaces
{
	
	/**
	 * 命令数据的规范集合。每个命令数据都应该包含一些特定属性<br/>
	 * 比如传递的原始数据originData，可能被修改的数据newData，命令的类型type
	 * 和与命令相关的消息名称（注册消息命令时使用的notificationName）
	 * */
	public interface ICommandData
	{
		/**命令初始化的数据*/
		function set data( data:* ):void;
		
		/**
		 * 命令的原始数据,通常用来做撤销的数据还原。<br/>
		 * 注意该数据为命令携带数据的深拷贝（数据内容完全一致，但和命令携带数据的内存地址不一致。可理解为值传递）
		 * */
		function get originData():*;
		
		/**命令的当前数据（通常经过一些列的操作可能会导致该数据于原始数据产生区别）*/
		function get newData():*;
		
		/**与命令产生绑定的消息名称（notificationName）*/
		function get name():String;
		
		/**命令携带的类型*/
		function get type():String;
	}
}