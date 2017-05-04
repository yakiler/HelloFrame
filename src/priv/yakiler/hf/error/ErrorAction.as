package priv.yakiler.hf.error
{
	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.events.UncaughtErrorEvent;
	
	import mx.formatters.DateFormatter;

	public class ErrorAction
	{
		private var loaderInfo:LoaderInfo;
		/**发送错误异常后是否取消默认行为*/
		private var prevenDefault:Boolean;
		protected var message:String = "";
		protected var errorLogs:Object = {};
		
		/**
		 * 构造函数
		 * @param preventDefault:Boolean 发送错误异常后是否取消默认行为
		 * */
		public function ErrorAction( preventDefault:Boolean )
		{
			this.prevenDefault = preventDefault;
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
			if( prevenDefault ) 
			{
				event.preventDefault();
			}
			
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