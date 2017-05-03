/* ***********************************************************************
   ActionScript 3 Tutorial by Barbara Kaskosz

   http://www.flashandmath.com/

   Last modified: January 30, 2011
 ************************************************************************ */

package
{
	public class Tile
	{
		private var _visited:Boolean;
		private var _north:Boolean;
		private var _east:Boolean;
		private var _south:Boolean;
		private var _west:Boolean;
		private var _row:int;
		private var _col:int;
		private var _neighbors:Array;

		public function Tile()
		{
			visited = false;
			south = true;
			north = true;
			west = true;
			east = true;
		}

		public function get visited():Boolean
		{
			return _visited;
		}
		public function set visited(value:Boolean):void
		{
			_visited = value;
		}

		public function get north():Boolean
		{
			return _north;
		}
		public function set north(value:Boolean):void
		{
			_north = value;
		}
		public function get east():Boolean
		{
			return _east;
		}
		public function set east(value:Boolean):void
		{
			_east = value;
		}
		public function get south():Boolean
		{
			return _south;
		}
		public function set south(value:Boolean):void
		{
			_south = value;
		}
		public function get west():Boolean
		{
			return _west;
		}
		public function set west(value:Boolean):void
		{
			_west = value;
		}

		public function get row():int
		{
			return _row;
		}
		public function set row(value:int):void
		{
			_row = value;
		}
		public function get col():int
		{
			return _col;
		}
		public function set col(value:int):void
		{
			_col = value;
		}

		public function get neighbors():Array
		{
			return _neighbors;
		}

		public function set neighbors(value:Array):void
		{
			_neighbors = value;
		}
	}
}