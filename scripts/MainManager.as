/* ***********************************************************************
   ActionScript 3 Tutorial by Barbara Kaskosz

   http://www.flashandmath.com/

   Last modified: January 31, 2011
 ************************************************************************ */

package
{
	/*
	   We are importing our custom AS3 classes: MazeDisplay, MazeDataGenerator,
	   and MazeCell. We use directly MazeDisplay only. The latter class uses
	   the other two.
	 */
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/*
	   MazeDisplay extends Sprite. We create an instance of the class and
	   add it to the Display List.
	 */
	public class MainManager extends MovieClip
	{
		//Global Maze obj
		//var mazeDisp:MazeDisplay;
		
		// Maze Params
		var posX:Number = 25;
		var posY:Number = 140;
		var numRows:int = 14;
		var numCols:int = 25;
		var cellSize:Number = 30;
			

		public function MainManager()
		{
			// Maze Generation
			//BuildMaze();

			//btnNext.visible = false;
			

			//btnNext.addEventListener(MouseEvent.CLICK, null);
		}

		function readyHandler(e:Event):void
		{
			//btnNext.visible = true;
		}

		function newGame() {
			
		}
		
		
		function BuildMaze() {
			//The main method of MazeDisplay is the 'createMaze' method. The method
			//takes the number of rows, the number of columns, and the size of one cell
			//as parameters. The moe rows and columns the more complex the puzzle.

			//When the method finishes, the class dispatches a custom event MazeDisplay.MAZE_READY.
			//We listen to the event to make all the buttons visible.
			mazeDisp = new MazeDisplay();
			
			// Add to ???
			this.addChild(mazeDisp);			
			mazeDisp.x = posX;
			mazeDisp.y = posY;
			
			
			mazeDisp.addEventListener(MazeDisplay.MAZE_READY, readyHandler);
			mazeDisp.createMaze(numRows, numCols, cellSize);
			
		}
		
		function createMaze(numRows:int, numCols:int, size:int) {
			mazeDisp.createMaze(numRows, numCols, cellSize);
		}
	}
}