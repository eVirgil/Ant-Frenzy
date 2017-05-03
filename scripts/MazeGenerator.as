/* ***********************************************************************
   ActionScript 3 Tutorial by Barbara Kaskosz

   http://www.flashandmath.com/

   Last modified: January 30, 2011
 ************************************************************************ */

package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class MazeGenerator extends EventDispatcher
	{
		public static const DATA_READY:String = "dataReady";

		private var _numRows:int;
		private var _numCols:int;

		private var _dataArray:Array;

		public function MazeGenerator()
		{

		}

		public function createMazeData(r:int, c:int):void
		{
			numRows = r;
			numCols = c;
			_dataArray = [];

			for (var i:int = 0; i < numRows; i++)
			{
				_dataArray[i] = [];

				for (var j:int = 0; j < numCols; j++)
				{
					_dataArray[i][j] = new Tile();
					_dataArray[i][j].row = i;
					_dataArray[i][j].col = j;
				}
			}

			var curRow:int = Math.floor(Math.random() * numRows);
			var curCol:int = Math.floor(Math.random() * numCols);

			var visitedList:Array = [];
			visitedList.push([curRow, curCol]);
			var curCell:Tile = _dataArray[curRow][curCol];
			curCell.visited = true;
			var numVisited:int = 1;

			while (numVisited < cellsTotal)
			{
				curCell.neighbors = [];

				if (curRow - 1 >= 0 && _dataArray[curRow - 1][curCol].visited == false)
				{
					curCell.neighbors.push("north");
				}

				if (curRow + 1 < numRows && _dataArray[curRow + 1][curCol].visited == false)
				{
					curCell.neighbors.push("south");
				}

				if (curCol - 1 >= 0 && _dataArray[curRow][curCol - 1].visited == false)
				{
					curCell.neighbors.push("west");
				}

				if (curCol + 1 < numCols && _dataArray[curRow][curCol + 1].visited == false)
				{
					curCell.neighbors.push("east");
				}

				if (curCell.neighbors.length > 0)
				{
					var randNeighbor:int = Math.floor(Math.random() * curCell.neighbors.length);

					if (curCell.neighbors[randNeighbor] == "north")
					{
						curCell.north = false;
						curCell = _dataArray[curRow - 1][curCol];
						curCell.south = false;
						curCell.visited = true;
						curRow = curCell.row;
						curCol = curCell.col;
						numVisited += 1;
						visitedList.push([curRow, curCol]);
					}
					else if (curCell.neighbors[randNeighbor] == "south")
					{
						curCell.south = false;
						curCell = _dataArray[curRow + 1][curCol];
						curCell.north = false;
						curCell.visited = true;
						curRow = curCell.row;
						curCol = curCell.col;
						numVisited += 1;
						visitedList.push([curRow, curCol]);
					}
					else if (curCell.neighbors[randNeighbor] == "west")
					{
						curCell.west = false;
						curCell = _dataArray[curRow][curCol - 1];
						curCell.east = false;
						curCell.visited = true;
						curRow = curCell.row;
						curCol = curCell.col;
						numVisited += 1;
						visitedList.push([curRow, curCol]);
					}
					else if (curCell.neighbors[randNeighbor] == "east")
					{
						curCell.east = false;
						curCell = _dataArray[curRow][curCol + 1];
						curCell.west = false;
						curCell.visited = true;
						curRow = curCell.row;
						curCol = curCell.col;
						numVisited += 1;
						visitedList.push([curRow, curCol]);
					}
				}
				else
				{
					var backArray:Array = visitedList.pop();
					curRow = backArray[0];
					curCol = backArray[1];
					curCell = _dataArray[curRow][curCol];
				}
			}

			if (numVisited == cellsTotal)
			{
				dispatchEvent(new Event(MazeGenerator.DATA_READY));
			}
		}

		public function get dataArray():Array
		{
			return _dataArray;
		}
		public function get numRows():int
		{
			return _numRows;
		}
		public function set numRows(value:int):void
		{
			_numRows = value;
		}
		public function get numCols():int
		{
			return _numCols;
		}

		public function set numCols(value:int):void
		{
			_numCols = value;
		}

		public function get cellsTotal():int
		{
			return numRows * numCols;
		}
	}
}