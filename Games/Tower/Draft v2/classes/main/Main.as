/**
Organization of layers:
Each statement is a single layer
Order from High Z index to low Z index.

- Background (solid color || gradient)
- Cloud and Bird Background
- Level blocks
- Button butterfly effects, and other button background stuff
- Buttons (Play, level select)
- Sparks, explosions, thunder bolts
- Extra clouds
- Labels (Player name, Rank, Points)
- Credit and Options buttons
- Message background (.8 alpha)
- Message
- Mouse effects
- Custom mouse?

Bugs:
- Fader/Credits screws up sometimes
- Fix dynamic fader

To do:
- Fix up memory with birds (make limited number of birds)
*/
package main{
	//Import foreign classes
	import game.Game;

	//import flash classes
	import flash.display.MovieClip;
	import flash.events.ContextMenuEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	public class Main extends MovieClip {
		var game:Game = new Game();
		public function Main():void {
			addChild(game);
			addHighscoreApi();
			addRightClickMenu();
		}
		
		private function addHighscoreApi():void {
			Security.allowDomain("www.granttimmerman.com");
		}
		
		/**
		 * Adds the right click menu
		 **/
		private function addRightClickMenu():void {
			//right click menu
			var rightClickMenu:ContextMenu = new ContextMenu();
			//rightClickMenu.hideBuiltInItems();
			rightClickMenu.builtInItems.forwardAndBack=false;
			rightClickMenu.builtInItems.loop=false;
			rightClickMenu.builtInItems.play=false;
			rightClickMenu.builtInItems.print=false;
			
			rightClickMenu.builtInItems.quality=true;
			
			rightClickMenu.builtInItems.rewind=false;
			rightClickMenu.builtInItems.save=false;
			rightClickMenu.builtInItems.zoom=false;

			//custom right click buttons
			var madeBy:ContextMenuItem=new ContextMenuItem("Made by Grant Timmerman");
			var moreGames:ContextMenuItem=new ContextMenuItem("Play more games!");
			moreGames.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,launchMoreGames,false,0,true);
			rightClickMenu.customItems.push(madeBy,moreGames);
			
			contextMenu=rightClickMenu;
		}
		/**
		 * Right click menu item function
		 **/
		private function launchMoreGames(e:ContextMenuEvent):void {
			navigateToURL(new URLRequest("http://www.granttimmerman.com/games/index.php"),"_blank");
		}
	}
}