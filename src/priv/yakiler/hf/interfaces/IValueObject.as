package priv.yakiler.hf.interfaces
{
	/**
	 * 数据视图接口。VO（即：ValueObject，所有VO类都应该实现此接口）和
	 * Model的区别是，VO不应该包含任何方法（除构造函数），也不应该引入任何逻辑，视图，工具等任何包。<br/>
	 * VO是作为数据可持久化的最大单元结构。<br/>
	 * 如非必要应该尽量避免VO引入其它任何类定义。
	 * @see priv.yakiler.hf.interfaces.IModel
	 * **/
	public interface IValueObject
	{
		
	}
}