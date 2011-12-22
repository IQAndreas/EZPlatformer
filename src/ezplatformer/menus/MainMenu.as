package
ezplatformer.menus{
	import ezplatformer.PlayState;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	/**
	 * @author andreas
	 */
	public class MainMenu extends FlxState
	{
		public function MainMenu()
		{
			super(0xff000000, false); 
		}
		
		public override function create():void
		{
			var gameText:FlxText = new FlxText(0,(FlxG.height/2) - 80, FlxG.width, "EZPlatformer");
			//gameText = new FlxText(0,0, FlxG.width, "EZPlatformer!");
			gameText.setFormat( null, 32, 0xffCC0000, "center", 0xFF333333);
			add(gameText);
			
			var anyKeyText:FlxText = new FlxText(0, FlxG.height-24, FlxG.width, "PRESS ANY KEY TO PLAY");
			anyKeyText.setFormat( null, 8, 0xffffffff,"center");
			add(anyKeyText);
		}
		
		private var starting:Boolean = false;
		public override function update():void
		{
			super.update();
			
			if (!starting && FlxG.keys.any())
			{
				starting = true;
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, startGame);
			}
		}
		
		public function startGame():void
		{
			FlxG.switchState(new PlayState());
		}
		
	}
}
