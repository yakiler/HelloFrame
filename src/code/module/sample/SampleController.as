package code.module.sample
{
	import flash.events.Event;
	
	import code.app.mvc.Command;
	import code.app.mvc.Controller;
	import code.module.sample.command.SampleCommand;
	import code.module.sample.model.SampleModel;
	import code.module.sample.view.SampleView;
	
	
	/**
	 * 示例控制器
	 * @author dom
	 */
	public class SampleController extends Controller
	{
		public function SampleController()
		{
			super();
		}
		
		
		private var model:SampleModel;
		private var view:SampleView;
		/**
		 * 初始化控制器
		 */		
		override protected function init():void
		{
			model = new SampleModel();
			view = new SampleView();
		}
		/**
		 * 初始化事件和命令监听
		 */		
		override protected function initListeners():void
		{
			view.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addCommand(SampleCommand.SAMPLE_COMMAND_TEST,onSampleCommandTest);
		}
		
		private function onSampleCommandTest(cmd:SampleCommand):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
	}
}