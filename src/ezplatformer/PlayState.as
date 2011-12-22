package
ezplatformer{
	import ezplatformer.menus.GameOverMenu;
	import ezplatformer.menus.MainMenu;
	import ezplatformer.menus.PauseMenu;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxSubState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;

	public class PlayState extends FlxState
	{
		public var level:FlxTilemap;
		public var exit:FlxSprite;
		public var coins:FlxGroup;
		public var player:FlxSprite;
		
		public function PlayState()
		{
			//Set the background color to light gray (0xAARRGGBB)
			//Do not use the mouse for anything
			super(0xffaaaaaa, false);
		}
		
		override public function create():void
		{
			super.create();
			
			//Just to simplify and avoid too much code in here!
			generateLevel1(this);
			
			//Create player (a red box)
			player = new FlxSprite(FlxG.width/2 - 5);
			player.makeGraphic(10,12,0xffaa1111);
			player.maxVelocity.x = 80;
			player.maxVelocity.y = 200;
			player.acceleration.y = 200;
			player.drag.x = player.maxVelocity.x*4;
			add(player);
			
			scoreText = new FlxText(2,2,80);
			scoreText.shadow = 0xff000000;
			add(scoreText);
			
			statusText = new FlxText(FlxG.width-160-2,2,160);
			statusText.shadow = 0xff000000;
			statusText.alignment = "right";			
			add(statusText);
			
			this.score = 0;
			this.status = "Collect coins.";
		}
		
		override public function update():void
		{
			//Prevent the game from continuing (which may mean that the player wins or looses during
			// the time between they choose to quit, to the time the fade out has occurred and they are
			// actually gone, causing another state to start.)
			if (quitting) { return; }
			
			if (FlxG.keys.justPressed("ESCAPE") || FlxG.keys.justPressed("P"))
			{
				this.setSubState(new PauseMenu(), onMenuClosed);
			}
			
			//Player movement and controls
			player.acceleration.x = 0;
			if(FlxG.keys.LEFT)
				player.acceleration.x = -player.maxVelocity.x*4;
			if(FlxG.keys.RIGHT)
				player.acceleration.x = player.maxVelocity.x*4;
			if(FlxG.keys.justPressed("SPACE") && player.isTouching(FlxObject.FLOOR))
				player.velocity.y = -player.maxVelocity.y/2;
			
			//Updates all the objects appropriately
			super.update();

			//Check if player collected a coin or coins this frame
			FlxG.overlap(coins,player,getCoin);
			
			//Check to see if the player touched the exit door this frame
			FlxG.overlap(exit,player,reachedExit);
			
			//Finally, bump the player up against the level
			FlxG.collide(level,player);
			
			//Check for player lose conditions
			if(player.y > FlxG.height)
			{
				this.gameOver(false);
			}
		}
		
		//Called whenever the player touches a coin
		private function getCoin(Coin:FlxSprite,Player:FlxSprite):void
		{
			Coin.kill();
			
			this.score += 100;
			
			if(coins.countLiving() == 0)
			{
				this.status = "Find the exit.";
				exit.exists = true;
			}
		}
		
		//Called whenever the player touches the exit
		private function reachedExit(Exit:FlxSprite,Player:FlxSprite):void
		{
			this.score += 1000;
			this.gameOver(true);
		}
		
		private function gameOver(winner:Boolean = false):void
		{
			this.status = "";
			scoreText.text = "";
			player.kill();
			
			this.setSubState(new GameOverMenu(_score, winner), onMenuClosed);
		}
		
		private function onMenuClosed(state:FlxSubState, result:String):void
		{
			if ((result == PauseMenu.QUIT_GAME) || (result == GameOverMenu.QUIT))
			{
				//Exit to main menu
				this.quitting = true;
				FlxG.fade(0xff000000, 1.5, quit);
			}
			else if (result == GameOverMenu.RESTART)
			{
				FlxG.resetState();
			}
			
			//else - keep playing
		}
		
		private var quitting:Boolean = false;
		private function quit():void
		{
			FlxG.switchState(new MainMenu()); 
		}
		
		
		
		public var scoreText:FlxText;
		public var statusText:FlxText;
		
		private var _score:int = 0;
		public function get score():uint { return _score; }
		public function set score(value:uint):void
		{
			_score = value;
			scoreText.text = "SCORE: " + String(_score);
		}
		
		private var _status:String = "";
		public function get status():String { return _status; }
		public function set status(value:String):void
		{
			_status = value;
			statusText.text = _status;
		}
		
	}
}
