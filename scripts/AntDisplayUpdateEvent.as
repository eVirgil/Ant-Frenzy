package
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Team 7
	 */
	public class AntDisplayUpdateEvent extends Event
	{
		public static const	ANT_DISP_UPDATE = "ANT_DISP_UPDATE";

		public var sugar1PickedUp:Boolean, sugar2PickedUp:Boolean, sugar3PickedUp:Boolean;
		public var fire1PickedUp:Boolean, fire2PickedUp:Boolean, fire3PickedUp:Boolean;

		public var sugar1DroppedOff:Boolean, sugar2DroppedOff:Boolean, sugar3DroppedOff:Boolean;
		public var fire1DroppedOff:Boolean, fire2DroppedOff:Boolean, fire3DroppedOff:Boolean;

		public function AntDisplayUpdateEvent(title:String)
		{
			super(title);

			sugar1PickedUp = false;
			sugar2PickedUp = false;
			sugar3PickedUp = false;
			fire1PickedUp = false;
			fire2PickedUp = false;
			fire3PickedUp = false;

			sugar1DroppedOff = false;
			sugar2DroppedOff = false;
			sugar3DroppedOff = false;
			fire1DroppedOff = false;
			fire2DroppedOff = false;
			fire3DroppedOff = false;
		}
	}
}