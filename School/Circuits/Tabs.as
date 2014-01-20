package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Tabs extends MovieClip {
		//constants
		private const TAB_WIDTH:uint = 120;
		private const TAB_HEIGHT:uint = 20;
		private const TAB_OVERLAP:uint = 5;
		//variables
		private var numTabs:uint = 0;
		//tab arrays
		private var bgTabs:Array = new Array();
		private var currentTabs:Array = new Array();
		//parent
		private var par:MovieClip;
		public function Tabs():void {
			addBgLayer();
			addCurrentLayer();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//adds the tab bg layer
		private function addBgLayer():void {
			//find num tabs
			var tab:Tab = new Tab(-1,0,0,0,0);
			numTabs = tab.getTotalTabs();
			//
			for(var i:uint = 0;i<numTabs;++i) {
				bgTabs.push(new Tab(numTabs-i-1,((TAB_WIDTH-TAB_OVERLAP)*(numTabs-i-1)),0,TAB_WIDTH,TAB_HEIGHT));
				addChild(bgTabs[i]);
			}
		}
		
		//adds the current layer
		private function addCurrentLayer():void {
			for(var i:uint = 0;i<numTabs;++i) {
				currentTabs.push(new CurrentTab(numTabs-i-1,((TAB_WIDTH-TAB_OVERLAP)*(numTabs-i-1)),0,TAB_WIDTH,TAB_HEIGHT));
				if(i!=numTabs-1) {//don't turn first one off
					currentTabs[i].turnOff();
				}
				addChild(currentTabs[i]);
			}
		}
		
		//gos to the tab
		public function toTab(tabNum:uint):void {
			updateCurrentTab(tabNum);
			par.toPage(tabNum);
		}
		
		//updates the currentTab
		private function updateCurrentTab(tabNum:uint):void {
			tabNum = numTabs-tabNum-1;
			for(var i:uint = 0;i<numTabs;++i) {
				currentTabs[i].turnOff();
				if(i!=tabNum) {
					currentTabs[i].turnOff();
				} else {
					currentTabs[i].turnOn();
				}
			}
		}
	}
}