package priv.yakiler.hf.uitl
{
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.LogLogger;
	import mx.logging.targets.TraceTarget;

	/**日志工具,正式版将自动屏蔽此工具中的方法*/
	public class LogUtil
	{
		public function LogUtil()
		{
		}
		
		/**生成一个日志记录器*/
		public static function getLogger(category:String):LogLogger
		{
			var log:LogLogger = new LogLogger(category);
			var traceTarget:TraceTarget = new TraceTarget();
			traceTarget.level = LogEventLevel.ALL;
			traceTarget.includeCategory = true;
			traceTarget.includeLevel = true;
			traceTarget.includeDate = false;
			traceTarget.includeTime = true;
			traceTarget.addLogger(log);
			Log.addTarget(traceTarget);
			return log;
		}
		
	}
}