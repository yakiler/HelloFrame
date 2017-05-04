package priv.yakiler.hf.uitl
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	
	import priv.yakiler.hf.enum.LocaleEnum;

	/**
	 * LocaleUtil 类是一个全静态类，其方法用于处理语言环境相关。
	 * 不创建 LocaleUtil 的实例；只是调用如 LocaleUtil.currentLocale() 之类的静态方法。
	 * */
	public class LocaleUtil
	{
		public function LocaleUtil()
		{
		}
		
		public static const resourceManager:IResourceManager = ResourceManager.getInstance();
		/**
		 * 切换当前语言环境，将立即更新国际化语言条目，如果某些语言条目产生绑定将马上更新到视图上。
		 * */
		public static function set currentLocale( locale:LocaleEnum ):void
		{
			if( locale )
			{
				resourceManager.localeChain = [ locale.toString() ];	
			}
		}
		
	}
}