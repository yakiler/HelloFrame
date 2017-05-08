package priv.yakiler.hf.dataStructure
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * 队列（数组形式）的简单实现，与栈不同的是它总是先进后出。
	 * */
	public class Queue implements IEventDispatcher
	{
		//TODO: 由于数组在开头的操作（插入、删除）很慢，需要优化。尝试将队列拆分为2个数组，
		//一个数组用于入队，一个数组装填元数据
		
		// ---------------------------------------------------------------------------------
		//
		//		静态常量
		//
		// ---------------------------------------------------------------------------------
		/**初始化队列完成*/
		public static const INITQUEUE_COMPLATE:String  = "initQueueComplate";
		/**队列入队完成事件*/
		public static const INTO_QUEUE:String = "intoQueue";
		/**队列出队完成事件*/
		public static const OUT_QUEUE:String  = "outQueue";
		/**队列清空事件*/
		public static const REMOVE_ALL:String = "removeAll";
		
		
		
		// ---------------------------------------------------------------------------------
		//
		//		属性
		//
		// ---------------------------------------------------------------------------------
		/**
		 *  事件驱动器
		 */
		private var eventDispatcher:EventDispatcher;
		
		/**活动的数据集合*/
		private var datas:Array = [];
		
		
		// ---------------------------------------------------------------------------------
		//
		//		构造函数
		//
		// ---------------------------------------------------------------------------------
		
		public function Queue()
		{
			eventDispatcher = new EventDispatcher( this );
		}
		
		
		// ---------------------------------------------------------------------------------
		//
		//		方法
		//
		// ---------------------------------------------------------------------------------
		
		/**清空队列*/
		public function removeAll():void
		{
			datas = [];
			dispatchEvent( new Event(REMOVE_ALL) );
		}
		
		/**初始化队列，会自动去除所有空数据*/
		public function initQueue( datas:Array ):void
		{
			if( datas && datas.length )
			{
				for (var i:int = 0; i < datas.length; i++) 
				{
					if(datas[i])
					{
						this.datas.push( datas[i] );
						dispatchEvent( new Event(INITQUEUE_COMPLATE) );
					}
				}
			}
		}
		
		/**入队*/
		public function intoQueue( data:* ):void
		{
			if( data )
			{
				this.datas.push( data );
				dispatchEvent( new Event(INTO_QUEUE) );
			}
		}
		
		/**出队,如果返回Null说明队列为空*/
		public function outQueue():*
		{
			if( datas.length > 0 )
			{
				var value:* = datas[0];
				datas.shift();
				dispatchEvent( new Event(OUT_QUEUE) );
				return value;
			}
			return null;
		}
		
		/**队列中是否存在该元素,isComparePointer是否比较指针*/
		public function hasOne( data:*, isComparePointer:Boolean = false ):Boolean
		{
			if( data )
			{
				for each (var i:* in datas) 
				{
					if( isComparePointer )
					{
						if( data == i )
						{
							return true;
						}
					}else
					{
						if( data === i )
						{
							return true;
						}
					}
				}
			}
			return false;
		}
		
		/**克隆一个队列*/
		public function clone():Queue
		{
			var queue:Queue = new Queue;
			queue.initQueue( datas );
			return queue;
		}
		
		
		// ---------------------------------------------------------------------------------
		//
		//		getter and  setter
		//
		// ---------------------------------------------------------------------------------
		
		/**维持队列的数组。注意返回的是一个浅表克隆的数组，通常用来检测队列内数据的索引，应尽量避免修改它*/
		public function get queue():Array
		{
			return datas.concat();
		}
		
		/**队头元素,返回null表示队列为空*/
		public function get head():*
		{
			return datas[0] || null;
		}
		
		/**队尾元素，返回null表示队列为空*/
		public function get tail():*
		{
			return datas[ datas.length - 1 ] || null;
		}
		
		/**队列长度*/
		public function get length():uint
		{
			return datas.length;
		}
		
		//--------------------------------------------------------------------------
		//
		// EventDispatcher methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function addEventListener(type:String,
										 listener:Function,
										 useCapture:Boolean = false,
										 priority:int = 0,
										 useWeakReference:Boolean = false):void
		{
			eventDispatcher.addEventListener(type, listener, useCapture,
				priority, useWeakReference);
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function removeEventListener(type:String,
											listener:Function,
											useCapture:Boolean = false):void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function hasEventListener(type:String):Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		/**
		 *  @inheritDoc
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function willTrigger(type:String):Boolean
		{
			return eventDispatcher.willTrigger(type);
		}
	}
}