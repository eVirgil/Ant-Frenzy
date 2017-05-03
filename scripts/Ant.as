package
{
	import flash.display.Shape;

	public class Ant extends Shape
	{
		private var _radius:Number;
		private var _speed:Number;

		private var _isSugarAnt:Boolean; // if not, fire ant

		private var _buddy1Held:Boolean;
		private var _buddy2Held:Boolean;
		private var _buddy3Held:Boolean;

		public function Ant()
		{
			_radius = 0;
			_speed = 15;
			_isSugarAnt = true;
			_buddy1Held = false;
			_buddy2Held = false;
			_buddy3Held = false;
		}

		public function draw():void
		{
			this.graphics.clear();
			this.graphics.lineStyle();
			this.graphics.beginFill(color);
			this.graphics.drawCircle(0, 0, radius);
			this.graphics.endFill();
		}

		public function get radius():Number
		{
			return _radius;
		}
		public function set radius(value:Number):void
		{
			_radius = value;
		}
		public function get speed():Number
		{
			return _speed;
		}
		public function set speed(value:Number):void
		{
			_speed = value;
		}

		// Ant type accessors
		public function get isSugarAnt():Boolean
		{
			return _isSugarAnt;
		}
		public function set isSugarAnt(value:Boolean):void
		{
			_isSugarAnt = value;
		}
		public function get color():uint
		{
			return _isSugarAnt ? 0x00FF00 : 0xCC0000;
		}
		public function get antType():String
		{
			return _isSugarAnt ? "black" : "red";
		}

		// Buddy ant accessors
		public function get anyBuddiesHeld():Boolean
		{
			return buddy1Held || buddy2Held || buddy3Held;
		}
		public function dropOffBuddies():void
		{
			buddy1Held = false;
			buddy2Held = false;
			buddy3Held = false;
		}
		public function get buddy1Held():Boolean
		{
			return _buddy1Held;
		}
		public function set buddy1Held(value:Boolean):void
		{
			_buddy1Held = value;
		}
		public function get buddy2Held():Boolean
		{
			return _buddy2Held;
		}
		public function set buddy2Held(value:Boolean):void
		{
			_buddy2Held = value;
		}
		public function get buddy3Held():Boolean
		{
			return _buddy3Held;
		}
		public function set buddy3Held(value:Boolean):void
		{
			_buddy3Held = value;
		}
	}
}