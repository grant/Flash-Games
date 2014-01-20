//parents:WorldViewer
//children:BackgroundModel,TilesModel,CharModel,InteractableObjectModel,EffectsModel
//M
//Stores information about the world
package {
	import flash.display.MovieClip;
	public class World extends MovieClip {
		//children models
		private var backgroundModel:BackgroundModel;
		private var tilesModel:TilesModel;
		private var charModel:CharModel;
		private var interactableObjectsModel:InteractableObjectsModel;
		private var effectsModel:EffectsModel;
		public function World():void {
			setNewWorld();
		}
		
		//
		//GETTERS
		//
		public function setNewWorld():void {
			backgroundModel = new BackgroundModel();
			tilesModel = new TilesModel();
			charModel = new CharModel();
			interactableObjectsModel = new InteractableObjectsModel();
			effectsModel = new EffectsModel();
			addChild(tilesModel);
		}
		
		//
		//SETTERS
		//
	}
}