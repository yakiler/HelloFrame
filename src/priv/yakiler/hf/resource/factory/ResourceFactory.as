package priv.yakiler.hf.resource.factory
{
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import priv.yakiler.hf.enum.HFErrorEnum;

	/**
	 * 资源池，于SingleFactory不同。它类似对象池，提供资源的重复使用。避免大量的初始化，提升程序性能。<br/>
	 * 注意：此资源池是为可重用资源提供缓存，应避免使用除以下之外的类型作用资源池。</br>
	 * <table>
	 * 	<tr>
	 * 		<td>Image</td>
	 * 		<td>Icon</td>
	 * 		<td>Bitmap</td>
	 * 		<td>BitmapData</td>
	 * 		<td>HttpService</td>
	 * 		<td>XML</td>
	 * 		<td>ByteArrat</td>
	 *  </tr>
	 * </table>
	 * */
	public class ResourceFactory
	{
		public function ResourceFactory()
		{
			
		}   
		
		protected static var resources:Dictionary = new Dictionary; 
		/**
		 * 获取已经存在的资源文件，如果需要创建一个新对象请使用<code>newReource()</code><br/>
		 * 注意：如果返回null说明该资源未通过<code>newResource()</code>创建，或者传入参数异常
		 * */
		public static function getResource( clazz:Class ):*
		{
			if( !clazz ) return null;
			if( exits( clazz ) )
			{
				return resources[ clazz ];
			}else
			{
				return null;
			}
		}
		
		/**检测资源池是否存在该资源*/
		public static function exits( clazz:Class ):Boolean
		{
			return clazz in resources;
		}
		
		/**
		 * 实例化一个资源，不管资源是否存在。
		 * 注意此方法会覆盖资源池，如果不希望这样请将fill设置为false
		 * */
		public static function newResource( clazz:Class, fill:Boolean = true ):*
		{
			if( !clazz )
			{
				throw HFErrorEnum.INPUT_PARAM_INVALITE;
			}
			var packageName:String = getQualifiedClassName( clazz );
			if( packageName )
			{
				registerClassAlias( packageName, clazz );
				var singleton:* = new clazz();
				if( fill )	
				{
					resources[ clazz ] = singleton;
				}
				return singleton;
			}else
			{
				throw HFErrorEnum.INPUT_PARAM_INVALITE;
			}
		}
		
		/**清空资源池，此方法不可回退*/
		public static function dispose():void
		{
			resources = new Dictionary;
		}
		
		/**
		 * 删除由ResourceFactory创建的实例
		 * */
		public static function removeResource( instance:* ):void
		{
			if( instance )
			{
				var clazz:Class;
				if( instance is Class )
				{
					delete resources[ instance ];
				}else if( instance is String )
				{
					try
					{
						clazz = getDefinitionByName( instance ) as Class;
						delete resources[ clazz ];
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
						delete resources[ clazz ];
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