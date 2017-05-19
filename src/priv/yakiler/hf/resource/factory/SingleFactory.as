package priv.yakiler.hf.resource.factory
{
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import priv.yakiler.hf.enum.HFErrorEnum;
	import priv.yakiler.hf.error.HFError;

	/**
	 * 单例工厂：生成和保存app内唯一实例，仅适用于有且只有一个实例的情况如：controller,manager,某些视图等。
	 * <p>注意：生成的实例会自动执行垃圾回收，如确认某些实例不需要回收，请至少保留一个引用。</p>
	 * */
	public class SingleFactory
	{
		public function SingleFactory()
		{
		}
		
		/**单例集合，主要存储一些管理器之类的实例。key是包名，value是唯一实例*/
		protected static var singletons:Dictionary = new Dictionary( true );
		
		/**获取app内唯一实例，如果不存在将会自动创建*/
		public static function getSingleInstance( clazz:Class ):*
		{
			if( !clazz )
			{
				throw HFErrorEnum.INPUT_PARAM_INVALITE;
			}
			if( singletons[ clazz ] ) 
			{
				return singletons[ clazz ];
			}else
			{
				var packageName:String = getQualifiedClassName( clazz );
				if( packageName )
				{
					registerClassAlias( packageName, clazz );
					var singleton:* = new clazz();
					singletons[ clazz ] = singleton;
					return singleton;
				}else
				{
					throw HFErrorEnum.INPUT_PARAM_INVALITE;
				}
			}
		}
		
		/**
		 * 注入实例，稍后可从全局任意位置通过单例工厂获取该实例
		 * */
		public static function injectInstance( instance:* ):void
		{
			var packageName:String = getQualifiedClassName( instance );
			var clazz:Class = getDefinitionByName( packageName ) as Class;
			if( packageName )
			{
				registerClassAlias( packageName, clazz );
				singletons[ clazz ] = instance;
			}else
			{
				throw HFErrorEnum.INPUT_PARAM_INVALITE;
			}
		}
		
		/**
		 * 删除由SingletonFactory创建的实例 和 通过<code>injectInstance</code>注入的实例
		 * */
		public static function removeInstance( instance:* ):void
		{
			if( instance )
			{
				var clazz:Class;
				if( instance is Class )
				{
					delete singletons[ instance ];
				}else if( instance is String )
				{
					try
					{
						clazz = getDefinitionByName( instance ) as Class;
						delete singletons[ clazz ];
					} 
					catch(error:Error) 
					{
					}
				}else
				{
					var packageName:String = getQualifiedClassName( instance );
					try
					{
						clazz = getDefinitionByName( packageName ) as Class;
						delete singletons[ clazz ];
					} 
					catch(error:Error) 
					{
					}
				}
			}else
			{
				throw HFErrorEnum.INPUT_PARAM_INVALITE;
			}
		}
	}
}