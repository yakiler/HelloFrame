package priv.yakiler.hf.uitl
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * 序列化工具类
	 * */
	public class SerializationUtil
	{
		public function SerializationUtil()
		{
		}
		
		/**
		 * 深度拷贝对象<br/>
		 * 注意：请勿拷贝非数据类对象（比如：显示对象等）
		 * */
		public static function deepCopyObject(original:Object):*
		{
//			var className:String=getQualifiedClassName(original);
//			var classZ:Class=getDefinitionByName(className)as Class;
//			registerClassAlias(className,classZ);
			var bytes:ByteArray=new ByteArray();
			bytes.writeObject(original);
			bytes.position=0;
			return bytes.readObject();
		}
	}
}