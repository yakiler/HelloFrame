package priv.yakiler.hf.enum
{
	import flash.utils.Dictionary;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import priv.yakiler.hf.error.HFError;

	/**
	 * 框架错误常量枚举，所有明确的错误异常均需要在这里预定义。可覆盖initErrorEnum()方法添加错误异常<br/>
	 * <code>override protected function initErrorEnum():void<br/>
	 * 		 {<br/>
	 *&nbsp;&nbsp;&nbsp;&nbsp;kingFrameErrorVector.push <br/>
	 *&nbsp;&nbsp;&nbsp;&nbsp;(<br/>
	 *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<br/>
	 *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CustomKingFrameError1,<br/>
	 *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CustomKingFrameError2<br/>
	 *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]<br/>
	 *&nbsp;&nbsp;&nbsp;&nbsp;);<br/>
	 * 		 }<br/>
	 * </code>
	 * */
	public class HFErrorEnum
	{
		protected static const resourceManager:IResourceManager = ResourceManager.getInstance();
		protected static const locale:String = resourceManager.localeChain && resourceManager.localeChain.length > 0 ? resourceManager.localeChain[0] : "en_US";
		
		protected static const _errorIDs:Vector.<uint> = new Vector.<uint>;
		
		protected static const _kingFrameErrorVector:Vector.<HFError> = new Vector.<HFError>;
		
		/**错误编号(errorID)重复*/
		public static const ERROR_ID_REPEAT:HFError =
			new HFError(resourceManager.getString("message","errorIDRepeat"), 10000);
		/**输入参数无效**/
		public static const INPUT_PARAM_INVALITE:HFError =
			new HFError(resourceManager.getString("message","inputParamInvalite"), 10009);
		/**资源文件不存在，请通过ResourceFactory.newResource()创建一个资源*/
		public static const RESOURCE_NO_EXIT:HFError = 
			new HFError(resourceManager.getString("message", "resourceNoExit"), 10010 );
		
		/**初始化错误常量定义，如果需要补充扩展，请覆盖此方法并将要添加的常量添加到kingFrameErrorVector中去*/
		protected function initErrorEnum():void
		{
			_kingFrameErrorVector[ ERROR_ID_REPEAT.errorID ]			 = ERROR_ID_REPEAT;
			_kingFrameErrorVector[ INPUT_PARAM_INVALITE.errorID ] 		 = INPUT_PARAM_INVALITE;
			_kingFrameErrorVector[ RESOURCE_NO_EXIT.errorID ] 		 	 = RESOURCE_NO_EXIT;
		}
		
		/**错误异常是否已经定义*/
		public static function exists( errorID:uint ):Boolean
		{
			return errorIDs.indexOf( errorID ) != -1;
		}
		
		/**ErrorID编号集合，用于检测编号是否重复**/
		public static function get errorIDs():Vector.<uint>
		{
			return _errorIDs;
		}
		
		/**错误定义集合，所有由KingFrame引发抛出的错误均需要预先定义。以便利于后续错误定位排查*/
		public static function get kingFrameErrorVector():Vector.<HFError>
		{
			return _kingFrameErrorVector;
		}
	}
}