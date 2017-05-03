package
{
	import flash.text.TextField;
	import flash.display.MovieClip;

	/**
	 * A class to manage the game's round system
	 *
	 * handles the ending and resetting of rounds, and the ending of the game after the win condition has been met
	 *
	 * @author Alex Manjarres
	 */
	public class RoundManager extends MovieClip
	{
		private var black1Deposited:Boolean, black2Deposited:Boolean, black3Deposited:Boolean;
		private var red1Deposited:Boolean, red2Deposited:Boolean, red3Deposited:Boolean;

		var roundsWon_black:Number, roundsWon_red:Number;

		var roundOver:Boolean = false;
		var gameOver:Boolean = false;

		const maxAntsPerRound:Number = 3;
		const maxRoundsPerGame:Number = 1;


		public function RoundManager()
		{
			black1Deposited = false;
			black2Deposited = false;
			black3Deposited = false;
			red1Deposited   = false;
			red2Deposited   = false;
			red3Deposited   = false;

			roundsWon_black = 0;
			roundsWon_red = 0;
		}

		/*
		 * a public function called by the player ant as it hits the maze end
		 * adds to the counter of whichever ant turned in their ants
		 * */
		public function depositAnts(playerCollecting:Ant):void
		{
			//if the ant was black, add it to antsDeposited_black
			if (playerCollecting.isSugarAnt)
			{
				if (playerCollecting.buddy1Held)
				{
					black1Deposited = true;
				}
				if (playerCollecting.buddy2Held)
				{
					black2Deposited = true;
				}
				if (playerCollecting.buddy3Held)
				{
					black3Deposited = true;
				}

				playerCollecting.dropOffBuddies();
				//trace("The sugar ants now have " + antsDeposited_black + " ant(s) deposited.");
				trace("Sugar ant deposited!");
			}
			//otherwise if the ant was red, add it to red's counter
			else
			{
				if (playerCollecting.buddy1Held)
				{
					red1Deposited = true;
				}
				if (playerCollecting.buddy2Held)
				{
					red2Deposited = true;
				}
				if (playerCollecting.buddy3Held)
				{
					red3Deposited = true;
				}

				playerCollecting.dropOffBuddies();
				//trace("The fire ants now have " + antsDeposited_black + " ant(s) deposited.");
				trace("Fire ant deposited!");
			}
		}


		/*
		 * a public function called by MazeDisplay.drawMaze()
		 *
		 *check if enough ants have been deposited by either side to end the round
		 * if so, end the game
		 * if not, reset the pieces for the new round
		 */
		public function checkIfRoundFinished():Boolean
		{
			//if one of the players has collected enough ants to end the round, end the round and add to their score
			if (black1Deposited && black2Deposited && black3Deposited)
			{
				roundsWon_black++;
				trace("Sugar ants win the round!");
				return true;
			}
			else if (red1Deposited && red2Deposited && red3Deposited)
			{
				roundsWon_red++;
				trace("Fire ants win the round!");
				return true;
			}
			return false;
		}


		/**
		 * a public function called by MazeDisplay.drawMaze()
		 *
		 * resets the placement of the ants and resets the antsDeposited counters to zero
		 *
		 */
		public function resetForNewRound()
		{
			trace("Set for new round!  Begin!");
			//pauses movement since the round has ended

			//resets the antsDeposited counters to zero for the new round
			black1Deposited = false;
			black2Deposited = false;
			black3Deposited = false;
			red1Deposited   = false;
			red2Deposited   = false;
			red3Deposited   = false;

			//sets the player ants back to their starting spots


			//resets the flag for roundOver to false since we're starting a new round
			roundOver = false;
		}

		/*
		 * a public function called by MazeDisplay.drawMaze()
		 *
		 *check if enough rounds have been won to end the game
		 * if so, end the game
		 * if not, reset the pieces for the new round
		 */

		public function checkIfGameFinished():Boolean
		{
			if(roundsWon_black + roundsWon_red >= maxRoundsPerGame)
			{
				gameOver = true;

				trace("Game finished!");
				if (roundsWon_black > roundsWon_red)
				{
					trace ("Sugar ants won the game!");
					return true;
				}
				else if (roundsWon_red > roundsWon_black)
				{
					trace ("Fire ants won the game!");
					return true;
				}
				//should not reach this false but necessary for no error
				return false;
			}
			else
			{
				return false;
			}
		}

		public function get whoWonGame():String
		{
			if (gameOver)
			{
				if (roundsWon_black > roundsWon_red)
				{
					return "black";
				}
				else if (roundsWon_red > roundsWon_black)
				{
					return "red";
				}
			}

			// if game is not over or score is tied (should not happen)
			return "none";
		}

		public function get antsDeposited_black():int
		{
			var number:int = 0;
			if (black1Deposited)
			{
				number += 1;
			}
			if (black2Deposited)
			{
				number += 1;
			}
			if (black3Deposited)
			{
				number += 1;
			}
			return number;
		}

		public function get antsDeposited_red():int
		{
			var number:int = 0;
			if (red1Deposited)
			{
				number += 1;
			}
			if (red2Deposited)
			{
				number += 1;
			}
			if (red3Deposited)
			{
				number += 1;
			}
			return number;
		}
	}
}