package
{
	import flash.display.CapsStyle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;


	public class MazeDisplay extends MovieClip
	{
		public static const MAZE_READY:String = "mazeReady";
		public static const FIRE_VICTORY:String = "FIRE_VICTORY";
		public static const SUGAR_VICTORY:String = "SUGAR_VICTORY";
		public static const PLAYER_MOVED:String = "PLAYER_MOVED";

		private var _numRows:int;
		private var _numCols:int;
		private var cellSize:Number;
		private var displayData:Array;
		private var mazeDataGen:MazeGenerator;
		public var ant1:Ant;
		public var ant2:Ant;

		public var myAntObj_black_0:AntObj;
		public var myAntObj_black_1:AntObj;
		public var myAntObj_black_2:AntObj;

		public var myAntObj_red_0:AntObj;
		public var myAntObj_red_1:AntObj;
		public var myAntObj_red_2:AntObj;

		public var rndMngr:RoundManager;

		private var antDepot_black_x:Number;
		private var antDepot_black_y:Number;
		private var antDepot_red_x:Number;
		private var antDepot_red_y:Number;

		private var getting_nerdy_sound:Sound;
		private var getting_buff_sound:Sound;
		private var myVoiceChannel_1:SoundChannel;
		private var myVoiceChannel_2:SoundChannel;

		public function MazeDisplay()
		{
			trace("Turn in all three ants of your color to win a round!");
			trace("First to three wins takes the game!");
			trace("Begin!");

			ant1 = new Ant();
			ant2 = new Ant();

			getting_nerdy_sound = new GettingNerdyAnt();
			getting_buff_sound = new GettingBuffAnt();
			myVoiceChannel_1 = new SoundChannel();
			myVoiceChannel_2 = new SoundChannel();

			myAntObj_black_0 = new AntObj();
			myAntObj_black_1 = new AntObj();
			myAntObj_black_2 = new AntObj();

			myAntObj_red_0 = new AntObj();
			myAntObj_red_1 = new AntObj();
			myAntObj_red_2 = new AntObj();


			//music and sound
			//inGameMusic = new InGameMusic();

			//myMusicChannel = new SoundChannel();

			rndMngr = new RoundManager();

			this.addChild(ant1);
			this.addChild(ant2);

			this.addChild(myAntObj_black_0);
			this.addChild(myAntObj_black_1);
			this.addChild(myAntObj_black_2);

			this.addChild(myAntObj_red_0);
			this.addChild(myAntObj_red_1);
			this.addChild(myAntObj_red_2);
		}

		public function createMaze(r:int, c:int, cs:Number):void
		{
			numRows = r;
			numCols = c;
			cellSize = cs;
			var halfSize:Number = Math.floor(cellSize / 2);
			var radius:Number = halfSize - 3;
			var speed:Number = 40;

			ant1.radius = radius;
			ant1.speed = speed;
			ant1.isSugarAnt = true; // Black
			//ant1.alpha = 0.15;

			ant2.radius = radius;
			ant2.speed = speed;
			ant2.isSugarAnt = false; // Red
			//ant2.alpha = 0.15;


			//TEMP FOR AntObj
			myAntObj_black_0.radius = radius;
			myAntObj_black_0.color = 0x00066;
			myAntObj_black_1.radius = radius;
			myAntObj_black_1.color = 0x00066;
			myAntObj_black_2.radius = radius;
			myAntObj_black_2.color = 0x00066;


			myAntObj_red_0.radius = radius;
			myAntObj_red_0.color = 0x510010;
			myAntObj_red_1.radius = radius;
			myAntObj_red_1.color = 0x510010;
			myAntObj_red_2.radius = radius;
			myAntObj_red_2.color = 0x510010;

			mazeDataGen = new MazeGenerator();
			mazeDataGen.addEventListener(MazeGenerator.DATA_READY, onDataReady);
			mazeDataGen.createMazeData(r, c);
		}

		private function onDataReady(e:Event):void
		{
			displayData = mazeDataGen.dataArray;
			drawMaze();
			drawAntObjs();
			drawAnts();
			dispatchEvent(new Event(MazeDisplay.MAZE_READY));
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
		}

		private function keyPressed(evt:KeyboardEvent):void
		{
			switch (evt.keyCode)
			{
				case Keyboard.W:
				case Keyboard.A:
				case Keyboard.S:
				case Keyboard.D:
					moveAnt1(evt);
					dispatchEvent(new Event(PLAYER_MOVED));
					break;

				case Keyboard.UP:
				case Keyboard.DOWN:
				case Keyboard.LEFT:
				case Keyboard.RIGHT:
					moveAnt2(evt);
					dispatchEvent(new Event(PLAYER_MOVED));
					break;

				default:
					break;
			}

		}

		private function moveAnt1(evt:KeyboardEvent):void
		{
			var nextX:Number;
			var nextY:Number;
			var curCol:int = int(Math.floor(ant1.x / cellSize));
			var curRow:int = int(Math.floor(ant1.y / cellSize));
			var nextCol:int;
			var nextRow:int;

			// WASD Controls (Player 1)
			if (evt.keyCode == Keyboard.D)
			{
				ant1.y = curRow * cellSize + cellSize / 2;

				nextX = ant1.x + ant1.speed;

				nextCol = int(Math.floor(nextX / cellSize));

				if (nextCol == curCol && displayData[curRow][curCol].east)
				{
					ant1.x = Math.min(ant1.x + ant1.speed, curCol * cellSize + cellSize / 2);
				}

				if (displayData[curRow][curCol].east == false)
				{
					ant1.x += ant1.speed;
				}
			}
			else if (evt.keyCode == Keyboard.A)
			{
				ant1.y = curRow * cellSize + cellSize / 2;

				nextX = ant1.x - ant1.speed;

				nextCol = int(Math.floor(nextX / cellSize));

				if (nextCol == curCol && displayData[curRow][curCol].west)
				{
					ant1.x = Math.max(ant1.x - ant1.speed, curCol * cellSize + cellSize / 2);
				}

				if (displayData[curRow][curCol].west == false)
				{
					ant1.x -= ant1.speed;
				}
			}
			else if (evt.keyCode == Keyboard.S)
			{
				ant1.x = curCol * cellSize + cellSize / 2;

				nextY = ant1.y + ant1.speed;

				nextRow = int(Math.floor(nextY / cellSize));

				if (nextRow == curRow && displayData[curRow][curCol].south)
				{
					ant1.y = Math.min(ant1.y + ant1.speed, curRow * cellSize + cellSize / 2);
				}

				if (displayData[curRow][curCol].south == false)
				{
					ant1.y += ant1.speed;
				}
			}
			else if (evt.keyCode == Keyboard.W)
			{
				ant1.x = curCol * cellSize + cellSize / 2;

				nextY = ant1.y - ant1.speed;

				nextRow = int(Math.floor(nextY / cellSize));

				if (nextRow == curRow && displayData[curRow][curCol].north)
				{
					ant1.y = Math.max(ant1.y - ant1.speed, curRow * cellSize + cellSize / 2);
				}

				if (displayData[curRow][curCol].north == false)
				{
					ant1.y -= ant1.speed;
				}
			}

			//picking up ants
			var pickUpEvent:AntDisplayUpdateEvent = new AntDisplayUpdateEvent(AntDisplayUpdateEvent.ANT_DISP_UPDATE);

			if (!myAntObj_black_0.alreadyPickedUp)
			{
				if (myAntObj_black_0.checkIfOnPickup(ant1))
				{
					trace("Sugar ants picked up an ant!");
					myAntObj_black_0.pickUp(ant1);
					ant1.buddy1Held = true;
					// add pickup to the event
					pickUpEvent.sugar1PickedUp = true;
					//play the voice sound
					myVoiceChannel_1 = getting_nerdy_sound.play();

				}
			}

			if (!myAntObj_black_1.alreadyPickedUp)
			{
				if (myAntObj_black_1.checkIfOnPickup(ant1))
				{
					trace("Sugar ants picked up an ant!");
					myAntObj_black_1.pickUp(ant1);
					ant1.buddy2Held = true;
					// add pickup to the event
					pickUpEvent.sugar2PickedUp = true;
					//play the voice sound
					myVoiceChannel_1 = getting_nerdy_sound.play();
				}
			}

			if (!myAntObj_black_2.alreadyPickedUp)
			{
				if (myAntObj_black_2.checkIfOnPickup(ant1))
				{
					trace("Sugar ants picked up an ant!");
					myAntObj_black_2.pickUp(ant1);
					ant1.buddy3Held = true;
					// add pickup to the event
					pickUpEvent.sugar3PickedUp = true;
					//play the voice sound
					myVoiceChannel_1 = getting_nerdy_sound.play();
				}
			}

			dispatchEvent(pickUpEvent);

			//depositing ants
			if (antDepot_black_x == ant1.x &&
				antDepot_black_y == ant1.y)
			{
				if (ant1.anyBuddiesHeld)
				{
					var updateEvent:AntDisplayUpdateEvent = new AntDisplayUpdateEvent(AntDisplayUpdateEvent.ANT_DISP_UPDATE);
					updateEvent.sugar1DroppedOff = ant1.buddy1Held;
					updateEvent.sugar2DroppedOff = ant1.buddy2Held;
					updateEvent.sugar3DroppedOff = ant1.buddy3Held;

					rndMngr.depositAnts(ant1);

					dispatchEvent(updateEvent);

					//check if round is finished, if so and if game is not finished, reset for the next round
					if (rndMngr.checkIfRoundFinished() == true)
					{
						if (rndMngr.checkIfGameFinished() == false)
						{
							rndMngr.resetForNewRound();

							ant1.dropOffBuddies();
							ant2.dropOffBuddies();

							myAntObj_black_0.reset();
							myAntObj_black_1.reset();
							myAntObj_black_2.reset();
							drawAntObjs();
							drawMaze();
						}
						else
						{
							myAntObj_black_0.graphics.clear();
							myAntObj_black_1.graphics.clear();
							myAntObj_black_2.graphics.clear();

							myAntObj_red_0.graphics.clear();
							myAntObj_red_1.graphics.clear();
							myAntObj_red_2.graphics.clear();

							ant1.graphics.clear();
							ant2.graphics.clear();

							this.graphics.clear();

							if (rndMngr.whoWonGame == "black")
							{
								dispatchEvent(new Event(SUGAR_VICTORY));
							}
							else if (rndMngr.whoWonGame == "red")
							{
								dispatchEvent(new Event(FIRE_VICTORY));
							}
						}
					}
				}
			}

			evt.updateAfterEvent();
		}

		//function that moves ant2 and does related checks for picking up antObbjs and depositing them and such
		private function moveAnt2(evt:KeyboardEvent):void
		{
			var nextX:Number;
			var nextY:Number;

			var curCol:int = int(Math.floor(ant2.x / cellSize));
			var curRow:int = int(Math.floor(ant2.y / cellSize));

			var nextCol:int;
			var nextRow:int;

			// UDLR Controls (Player 2)
			if (evt.keyCode == Keyboard.RIGHT)
			{
				ant2.y = curRow * cellSize + cellSize / 2;

				nextX = ant2.x + ant2.speed;

				nextCol = int(Math.floor(nextX / cellSize));

				if (nextCol == curCol && displayData[curRow][curCol].east)
				{
					ant2.x = Math.min(ant2.x + ant2.speed, curCol * cellSize + cellSize / 2);
				}

				if (displayData[curRow][curCol].east == false)
				{
					ant2.x += ant2.speed;
				}
			}
			else if (evt.keyCode == Keyboard.LEFT)
			{
				ant2.y = curRow * cellSize + cellSize / 2;

				nextX = ant2.x - ant2.speed;

				nextCol = int(Math.floor(nextX / cellSize));

				if (nextCol == curCol && displayData[curRow][curCol].west)
				{
					ant2.x = Math.max(ant2.x - ant2.speed, curCol * cellSize + cellSize / 2);
				}

				if (displayData[curRow][curCol].west == false)
				{
					ant2.x -= ant2.speed;
				}
			}
			else if (evt.keyCode == Keyboard.DOWN)
			{
				ant2.x = curCol * cellSize + cellSize / 2;

				nextY = ant2.y + ant2.speed;

				nextRow = int(Math.floor(nextY / cellSize));

				if (nextRow == curRow && displayData[curRow][curCol].south)
				{
					ant2.y = Math.min(ant2.y + ant2.speed, curRow * cellSize + cellSize / 2);
				}

				if (displayData[curRow][curCol].south == false)
				{
					ant2.y += ant2.speed;
				}
			}
			else if (evt.keyCode == Keyboard.UP)
			{
				ant2.x = curCol * cellSize + cellSize / 2;

				nextY = ant2.y - ant2.speed;

				nextRow = int(Math.floor(nextY / cellSize));

				if (nextRow == curRow && displayData[curRow][curCol].north)
				{
					ant2.y = Math.max(ant2.y - ant2.speed, curRow * cellSize + cellSize / 2);
				}

				if (displayData[curRow][curCol].north == false)
				{
					ant2.y -= ant2.speed;
				}
			}

			//picking up ants
			var pickUpEvent:AntDisplayUpdateEvent = new AntDisplayUpdateEvent(AntDisplayUpdateEvent.ANT_DISP_UPDATE);

			if (!myAntObj_red_0.alreadyPickedUp)
			{
				if (myAntObj_red_0.checkIfOnPickup(ant2))
				{
					trace("Fire ants picked up an ant!");
					myAntObj_red_0.pickUp(ant2);
					ant2.buddy1Held = true;
					// add pickup to the event
					pickUpEvent.fire1PickedUp = true;
					//play the voice sound
					myVoiceChannel_2 = getting_buff_sound.play();
				}
			}

			if (!myAntObj_red_1.alreadyPickedUp)
			{
				if (myAntObj_red_1.checkIfOnPickup(ant2))
				{
					trace("Fire ants picked up an ant!");
					myAntObj_red_1.pickUp(ant2);
					ant2.buddy2Held = true;
					// add pickup to the event
					pickUpEvent.fire2PickedUp = true;
					//play the voice sound
					myVoiceChannel_2 = getting_buff_sound.play();
				}
			}

			if (!myAntObj_red_2.alreadyPickedUp)
			{
				if (myAntObj_red_2.checkIfOnPickup(ant2))
				{
					trace("Fire ants picked up an ant!");
					myAntObj_red_2.pickUp(ant2);
					ant2.buddy3Held = true;
					// add pickup to the event
					pickUpEvent.fire3PickedUp = true;
					//play the voice sound
					myVoiceChannel_2 = getting_buff_sound.play();
				}
			}

			dispatchEvent(pickUpEvent);

			//depositing ants
			if (antDepot_red_x == ant2.x &&
				antDepot_red_y == ant2.y)
			{
				if (ant2.anyBuddiesHeld)
				{
					var updateEvent:AntDisplayUpdateEvent = new AntDisplayUpdateEvent(AntDisplayUpdateEvent.ANT_DISP_UPDATE);
					updateEvent.fire1DroppedOff = ant2.buddy1Held;
					updateEvent.fire2DroppedOff = ant2.buddy2Held;
					updateEvent.fire3DroppedOff = ant2.buddy3Held;

					rndMngr.depositAnts(ant2);

					dispatchEvent(updateEvent);

					//check if round is finished, if so and if game is not finished, reset for the next round
					if (rndMngr.checkIfRoundFinished() == true)
					{
						if (rndMngr.checkIfGameFinished() == false)
						{
							rndMngr.resetForNewRound();

							//resets the ants the player ants are carrying to zero
							ant1.dropOffBuddies();
							ant2.dropOffBuddies();

							//resets the antObjects to be able appear in the maze
							myAntObj_black_0.reset();
							myAntObj_black_1.reset();
							myAntObj_black_2.reset();

							myAntObj_red_0.reset();
							myAntObj_red_1.reset();
							myAntObj_red_2.reset();

							//draws the ant objs and makes a new maze
							drawAntObjs();
							drawMaze();
						}
						else
						{
							//since the game is over, make all the pieces in the maze disappear
							myAntObj_black_0.graphics.clear();
							myAntObj_black_1.graphics.clear();
							myAntObj_black_2.graphics.clear();

							myAntObj_red_0.graphics.clear();
							myAntObj_red_1.graphics.clear();
							myAntObj_red_2.graphics.clear();

							ant1.graphics.clear();
							ant2.graphics.clear();
							this.graphics.clear();

							this.graphics.clear();

							if (rndMngr.whoWonGame == "black")
							{
								dispatchEvent(new Event(SUGAR_VICTORY));
							}
							else if (rndMngr.whoWonGame == "red")
							{
								dispatchEvent(new Event(FIRE_VICTORY));
							}
						}
					}
				}
			}

			evt.updateAfterEvent();
		}

		//set up a new maze
		private function drawMaze():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(2, 0x74583E);

			for (var i:int = 0; i < numRows; i++)
			{
				var curY:Number = i * cellSize;
				var curRow:Array = displayData[i];

				for (var j:int = 0; j < numCols; j++)
				{
					var curX:Number = j * cellSize;

					if (curRow[j].south)
					{
						this.graphics.moveTo(curX, curY + cellSize);
						this.graphics.lineTo(curX + cellSize, curY + cellSize);
					}

					if (curRow[j].east)
					{
						this.graphics.moveTo(curX + cellSize, curY);
						this.graphics.lineTo(curX + cellSize, curY + cellSize);
					}
				}
			}

			var beg:int = Math.floor(.25 * numCols); // BegPoint (25%)
			var end:int = Math.floor(.75 * numCols); // EndPoint (75%)

			this.graphics.lineStyle(2, 0x74583E);
			this.graphics.drawRect(0, 0, displayWidth, displayHeight);
			this.graphics.lineStyle(6, 0x663300, 1.0, false, "normal", CapsStyle.NONE);
			this.graphics.moveTo(beg * cellSize, 0);
			this.graphics.lineTo(beg * cellSize + cellSize, 0);
			this.graphics.lineStyle(6, 0x663300, 1.0, false, "normal", CapsStyle.NONE);
			this.graphics.moveTo(end * cellSize, 0);
			this.graphics.lineTo(end * cellSize + cellSize, 0);

			//Ant1
			ant1.x = beg * cellSize + cellSize / 2;
			ant1.y = cellSize / 2;

			//Ant2
			ant2.x = end * cellSize + cellSize / 2;
			ant2.y = cellSize / 2;


			//Ant1
			antDepot_black_x = ant1.x;
			antDepot_black_y = ant1.y;

			//Ant2
			antDepot_red_x = ant2.x;
			antDepot_red_y = ant2.y;

			//randomizes positions for all the black and red antObjs
			randomizeObjectiveCoordinates(myAntObj_black_0);
			randomizeObjectiveCoordinates(myAntObj_black_1);
			randomizeObjectiveCoordinates(myAntObj_black_2);

			randomizeObjectiveCoordinates(myAntObj_red_0);
			randomizeObjectiveCoordinates(myAntObj_red_1);
			randomizeObjectiveCoordinates(myAntObj_red_2);
		}

		private function drawAnts():void
		{
			// Draw Ant1
			ant1.draw();

			// Draw Ant2
			ant2.draw();
		}

		private function drawAntObjs():void
		{
			//Draw the black antObjs
			myAntObj_black_0.draw();
			myAntObj_black_1.draw();
			myAntObj_black_2.draw();

			//Draw the red antObjs
			myAntObj_red_0.draw();
			myAntObj_red_1.draw();
			myAntObj_red_2.draw();
		}

		//called inside of DrawMaze, gives random x and y coordinates to the AntObj that's passed in
		private function randomizeObjectiveCoordinates(objToMove:AntObj):void
		{
			var beg_m_x:int = 0;
			var beg_m_y:int = 0;

			beg_m_x = Math.floor(Math.random() * numCols);
			beg_m_y = Math.floor(Math.random() * numRows);

			objToMove.x = beg_m_x * cellSize + cellSize / 2;
		    objToMove.y = beg_m_y * cellSize + cellSize / 2;
		}

		//getters and setters
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

		public function get displayWidth():Number
		{
			return numCols * cellSize;
		}
		public function get displayHeight():Number
		{
			return numRows * cellSize;
		}
	}
}