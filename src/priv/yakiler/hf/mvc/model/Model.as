package priv.yakiler.hf.mvc.model
{
	import priv.yakiler.hf.interfaces.IModel;
	import priv.yakiler.hf.interfaces.IValueObject;

	/**
	 * 数据模型：映射视图变化的数据驱动。它通常对应一个视图模块。<br/>
	 * 对于每一个视图模块您都应该定义一个Model。
	 * */
	public class Model implements IModel
	{
		public function Model()
		{
			
		}
		
		/**
		 * 数据初始化，每个数据实体都应该拥有一个初始化方法并集中在这里处理
		 * */
		public function initModel( value:Object = null ):void
		{
			
		}
	}
}