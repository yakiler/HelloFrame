package priv.yakiler.hf.event
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import priv.yakiler.hf.resource.factory.SingleFactory;

	public class HFDispatcher
	{
		private static const _instance : HFDispatcher = SingleFactory.getSingleInstance( HFDispatcher );
		private var eventDispatcher : IEventDispatcher;
		
		public function HFDispatcher( target:IEventDispatcher = null )
		{
			eventDispatcher = new EventDispatcher( target );
		}
		
		/**
		 * KingFrameDispatcher的唯一实例
		 */ 
		public static function get instace() : HFDispatcher
		{
			return _instance;
		}
		
		
		/**
		 * 添加侦听事件
		 */
		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, 
										  priority:int = 0, useWeakReference:Boolean = false ) : void
		{
			eventDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * 移出侦听事件
		 */
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ) : void
		{
			eventDispatcher.removeEventListener( type, listener, useCapture );
		}
		
		/**
		 * 抛出侦听事件
		 */
		public function dispatchEvent( event:HFEvent ) : Boolean
		{
			return eventDispatcher.dispatchEvent( event );
		}
		
		/**
		 * 检测侦听事件是否存在
		 */
		public function hasEventListener( type:String ) : Boolean
		{
			return eventDispatcher.hasEventListener( type );
		}
		
		/**
		 * Returns whether an event will trigger.
		 */
		public function willTrigger(type:String) : Boolean
		{
			return eventDispatcher.willTrigger( type );
		}
		
	}
}