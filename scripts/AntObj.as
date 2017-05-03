package
{
	public class AntObj extends MazeObj
	{
		public function AntObj()
		{

		}

		override public function pickUp(antToCheck):void
		{
			//antToCheck.antsHolding++;

			alreadyPickedUp = true;
			this.graphics.clear();
		}

		public function reset():void
		{
			alreadyPickedUp = false;
		}
	}
}