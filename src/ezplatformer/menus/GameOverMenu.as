package
ezplatformer.menus{
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxSubState;
	
	public class GameOverMenu extends FlxSubState
	{
		public function GameOverMenu(score:int, wonGame:Boolean = false)
		{
			this.score = score;
			this.wonGame = wonGame;
			super(true, 0x88000000);
		}
		
		public static const RESTART:String = "GameOverMenu::restart";
		public static const QUIT:String = "GameOverMenu::quit";
		
		private var score:int;
		private var wonGame:Boolean;
		
		public override function create():void
		{
			var gameText:FlxText = new FlxText(0,(FlxG.height/2) - 80, FlxG.width, (wonGame) ? "WINNER!" : "GAME OVER");
			gameText.setFormat( null, 24, (wonGame) ? 0xff00CC00 : 0xffCC0000, "center", 0xff666666);
			add(gameText);
			
			var scoreText:FlxText = new FlxText(0,gameText.y + gameText.height + 15, FlxG.width, "Score: " + String(score));
			scoreText.setFormat( null, 8, 0xffffffff, "center");
			add(scoreText);
			
			var quitText:FlxText = new FlxText(0, FlxG.height - 44, FlxG.width, "Press ESCAPE to quit.");
			quitText.setFormat( null, 8, 0xffffffff,"center");
			add(quitText);
			
			var anyKeyText:FlxText = new FlxText(0, quitText.y + quitText.height + 3, FlxG.width, "Press any other key to try again.");
			anyKeyText.setFormat( null, 8, 0xffffffff,"center");
			add(anyKeyText);
		}
		
		private var quitting:Boolean = false;
		public override function update():void
		{
			if (quitting) { return; }
			
			if (FlxG.keys.ESCAPE)
			{
				this.close(QUIT);
			}
			else if (FlxG.keys.any())
			{
				this.close(RESTART);
			}
		}
		
	}
}
