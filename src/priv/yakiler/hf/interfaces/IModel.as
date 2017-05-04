package priv.yakiler.hf.interfaces
{
	/**
	 * 数据模型接口。是一个模块内视图的数据驱动。<br/>
	 * 所有对数据的处理方法都应该定义在这里。<br/>
	 * IModel和IValueObject的区别是它可以拥有一些合理的类与包的引用和数据处理方法。
	 * @see priv.yakiler.hf.interfaces.IValueObject
	 * */
	public interface IModel
	{
		/**数据初始化，每个数据实体都应该拥有一个初始化方法并集中在这里处理*/
		function initModel( value:Object = null ):void;
	}
}