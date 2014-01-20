package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Message extends MovieClip {
		private var backSpeed:Number = 1;
		private var backAcceleration:Number=1;//0-1
		//Variables
		private var msgData:uint;
		private var addedData:Boolean=true;
		private var removedMessageData:Boolean = false;
		private var blackFading:Boolean;
		
		private var messageData:MessageData;
		private var par:MovieClip;
		public function Message(messageData:uint=1,blackFade:Boolean=false):void {
			blackFading = blackFade;
			x = 200;
			y = 200;
			scaleX*=.9;
			scaleY*=.9;
			msgData = messageData;
			addEventListener(Event.ENTER_FRAME,onLoop);
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onLoop(e:Event):void {
			if(currentFrame==50){
				addedData=true;
				messageData = new MessageData(msgData);
				addChild(messageData);
			} else if(currentFrame==60){
				stage.addEventListener(MouseEvent.CLICK,onClick);
			} else if(currentFrame==totalFrames){
				stop();
			}
		}
		private function onClick(e:MouseEvent):void {
			remove();
		}
		public function remove():void {
			addEventListener(Event.ENTER_FRAME,exit);
			stage.removeEventListener(MouseEvent.CLICK,onClick);
		}
		private function exit(e:Event):void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
			if(currentFrame-Math.round(backSpeed)>0){
				gotoAndStop(currentFrame-Math.round(backSpeed));
				backSpeed+=backAcceleration;
				if(currentFrame<50&&!removedMessageData){
					removedMessageData=true;
					messageData.remove();
					if(blackFading){
						par.blackFade.play();
					}
				}
			} else if(currentFrame>1){
				gotoAndStop(1);
			} else {
				removeEventListener(Event.ENTER_FRAME,exit);
				par.removeChild(this);
				par.credits = false;
			}
		}
	}
}