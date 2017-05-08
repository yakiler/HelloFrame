package priv.yakiler.hf.error
{
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.utils.Dictionary;
	
	import mx.formatters.DateFormatter;
	
	import priv.yakiler.hf.interfaces.IGlobalExceptionFilter;

	/**
	 * 全局异常侦听器：捕获全局异常，可指定某些异常是否允许取消默认事件
	 * */
	public class GlobalExceptionManager
	{
		private var loaderInfo:LoaderInfo;
		protected var message:String = "";
		protected var errorLogs:Object = {};
		protected var globalExceptionFilters:Vector.<IGlobalExceptionFilter>;
		
		/**
		 * 构造函数
		 * @param globalExceptionFilters:Vector.<IGlobalExceptionFilter> 指定的异常是否允许取消默认行为
		 * */
		public function GlobalExceptionManager( globalExceptionFilters:Vector.<IGlobalExceptionFilter> )
		{
			this.globalExceptionFilters = globalExceptionFilters;
		}
		
		/**初始化异常处理器，必须提供有效的loaderInfo*/
		public function init( loaderInfo:LoaderInfo ):void
		{
			if( loaderInfo ) this.loaderInfo = loaderInfo;
		}
		
		public function addEventListeners():void
		{
			if( loaderInfo && loaderInfo.uncaughtErrorEvents )
			{
				loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtErrorEvent);
			}
		}
		
		protected function onUncaughtErrorEvent(event:UncaughtErrorEvent):void
		{
			if(event.error is Error)
			{
				//只有FP11.5以上才能在非debug版本中调用getStackTrace()。
				message = event.error.getStackTrace();
				if(!message)
				{
					message = event.error.message;
				}
				
			}
			else if(event.error is ErrorEvent)
			{
				message = ErrorEvent(event.error).text;
			}
			else
			{
				message = event.error.toString();
			}
			
			errorLogs[ fmtDate(new Date) ] = message;
			
			message = "";
			
			if( getFilter( event.error ) )
			{
				event.preventDefault();
			}
		}
		
		/**获取指定异常的过滤器*/
		public function getFilter( errorClass:Class ):IGlobalExceptionFilter
		{
			for each (var globalExceptionFilter:IGlobalExceptionFilter in globalExceptionFilters) 
			{
				if( globalExceptionFilter.errorClass == errorClass )
				{
					return globalExceptionFilter;
				}
			}
			return null;
		}
		
		public function getLogs():String
		{
			var messages:String = "";
			for (var i:String in errorLogs) 
			{
				messages += i + " :: " + errorLogs[ i ] + "\n";
			}
			return messages;
		}
		
		protected function fmtDate( date:Date ):String
		{
			var df:DateFormatter = new DateFormatter();
			df.formatString = "YYYY/MM/DD HH:NN:SS";
			return df.format( date );
		}
	}
}