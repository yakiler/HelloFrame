package priv.yakiler.hf.interfaces
{
	/**
	 * 异常过滤器：可以指定特定的异常是否允许取消默认事件
	 * */
	public interface IGlobalExceptionFilter
	{
		/**异常的类型*/
		function get errorClass():Class;
		function set errorClass( clazz:Class ):void;
		
		/**是否允许取消默认事件**/
		function get preventDefault():Boolean;
		function set preventDefalut( preventDefault:Boolean ):void;
	}
}