package priv.yakiler.hf.mvc.command
{
	import priv.yakiler.hf.interfaces.ICommandData;
	import priv.yakiler.hf.namespaces.hf;
	import priv.yakiler.hf.uitl.SerializationUtil;

	/**
	 * 命令携带的数据。该数据包含注册命令时的消息名称，命令的类型和命令传递的数据
	 * */
	public class CommandData implements ICommandData
	{
		// ---------------------------------------------------------------------------------
		//
		//		构造函数
		//
		// ---------------------------------------------------------------------------------
		public function CommandData()
		{
		}
		
		// ---------------------------------------------------------------------------------
		//
		//		getter and setter
		//
		// ---------------------------------------------------------------------------------
		private var _type:String;

		/**命令的类型*/
		public function get type():String
		{
			return _type;
		}
		/**
		 * @private
		 */
		public function set type(value:String):void
		{
			_type = value;
		}

		/**
		 * @private 命令初始化的数据
		 */
		public function set data(value:*):void
		{
			_originData = value;
			_newData = SerializationUtil.deepCopyObject(value);
		}

		private var _originData:*;
		
		/**
		 * 命令的原始数据,通常用来做撤销的数据还原。<br/>
		 * 注意该数据为命令携带数据的深拷贝（数据内容完全一致，但和命令携带数据的内存地址不一致。可理解为值传递）
		 * */
		public function get originData():*
		{
			return _originData;
		}
		
		private var _newData:*;
		/**命令的当前数据（通常经过一些列的操作可能会导致该数据于原始数据产生区别）*/
		public function get newData():*
		{
			return _newData;
		}
		
		hf var _name:String;
		/**消息的名称*/
		public function get name():String
		{
			return hf::_name;
		}
		
		hf function set name( value:String ):void
		{
			hf::_name = value;
		}
		
		
		// ---------------------------------------------------------------------------------
		//
		//		函数
		//
		// ---------------------------------------------------------------------------------
		/**创建一个CommandData*/
		public static function createCommandData( data:* ,type:String  ):CommandData
		{
			var cd:CommandData = new CommandData;
			cd.hf::type = type;
			cd.data = data;
			return cd;
		}
		
		/**
		 * 克隆CommandData
		 * */
		public function clone():CommandData
		{
			var cd:CommandData = new CommandData;
			cd.type = type;
			cd.hf::name = name;
			cd.data = originData;
			return cd; 
		}
	}
}