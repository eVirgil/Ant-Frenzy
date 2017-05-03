package
{
	import flash.display.Shape;

	public class MazeObj extends Shape
	{
		private var _radius:Number;
		private var _color:uint;
		private var _alreadyPickedUp:Boolean;

		public function MazeObj()
		{
			_radius = 0;
			_alreadyPickedUp = false;
		}

		public function draw():void
		{
			this.graphics.clear();
			this.graphics.lineStyle();
			this.graphics.beginFill(color); // Black
			this.graphics.drawCircle(0, 0, radius);
			this.graphics.endFill();
		}

		public function checkIfOnPickup(antToCheck:Ant):Boolean
		{
			var deltaX = this.x - antToCheck.x;
			var deltaY = this.y - antToCheck.y;
			var distance:Number = Math.sqrt(deltaX * deltaX + deltaY * deltaY);

			if(distance < antToCheck.radius + this.radius)
			{
				//ant is on top of mazeObj, so do something
				alreadyPickedUp = true;
				return true;
			}

			//if the ant is not on top of the object, return false
			return false;
		}

		public function pickUp(antToCheck):void
		{
			alreadyPickedUp = true;
			this.graphics.clear();
		}

		public function get radius():Number
		{
			return _radius;
		}
		public function set radius(value:Number):void
		{
			_radius = value;
		}
		public function get color():uint
		{
			return _color;
		}
		public function set color(value:uint):void
		{
			_color = value;
		}
		public function get alreadyPickedUp():Boolean
		{
			return _alreadyPickedUp;
		}
		public function set alreadyPickedUp(value:Boolean):void
		{
			_alreadyPickedUp = value;
		}
	}
}