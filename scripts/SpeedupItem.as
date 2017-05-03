package
{
	import flash.display.MazeObj;

	public class SpeedupItem extends MazeObj
	{
		private var _radius:Number;
		private var _color:uint;
		private var _speedMultiplier:uint;

		public function mazeObj()
		{
			radius = 0;	
			speedMultiplier = 2;
		}
		
		
		public function draw():void
		{
			this.graphics.clear();
			this.graphics.lineStyle();
			this.graphics.beginFill(color); // Black
			this.graphics.drawCircle(0, 0, radius);
			this.graphics.endFill();
		}
		
		
		public function checkIfOnPickup(mazeObj objToPickUp, Ant antToCheck):int;
		{
				if (objToPickUp.x == antToCheck.x)
				{
					if (objToPickUp.y == antToCheck.y)
					{
					 //ant is on top of mazeObj, so do something
					 
					 return true;
					}
				}
				//if the ant is not on top of the object, return false
				return false;
		}
		
		
		//multiplies speed of the ant that picked it up by 2
		public function pickedUp(targetAnt):void
		{
			targetAnt.speed = targetAnt.speed * speedMultiplier;
		}
	}
}