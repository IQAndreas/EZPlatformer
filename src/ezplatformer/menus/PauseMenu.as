package ezplatformer.menus
{
	import flashx.textLayout.formats.TextAlign;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxSubState;

	/**
	 * @author andreas
	 */
	public class PauseMenu extends FlxSubState
	{
		public static const QUIT_GAME:String = "PauseMenu::quit_game";
		public static const RESUME_GAME:String = "PauseMenu::resume_game";
		
		public function PauseMenu()
		{
			super(true, 0x88000000, true);
		}
		
		public override function create():void
		{
			//Sorry about all the hardcoded position values. :(
			var currentY:Number = 50;
			
			var text:FlxText = new FlxText(0, currentY, FlxG.width, "PAUSED");
			text.setFormat(null, 24, 0xFFFFFF00, TextAlign.CENTER, 0xFFCCCCCC);
			this.add(text);
			currentY += text.height + 20;
			
			var resumeBtn:FlxButton = new FlxButton(0, currentY, "Resume game", resume);
			resumeBtn.x = (FlxG.width / 2) - (resumeBtn.width / 2);
			this.add(resumeBtn);
			currentY += resumeBtn.height + 5;
			
			var quitBtn:FlxButton = new FlxButton(0, currentY, "Quit game", tryQuit);
			quitBtn.x = (FlxG.width / 2) - (quitBtn.width / 2);
			this.add(quitBtn);
		}
		
		private function resume():void
		{
			this.close(RESUME_GAME);
		}
		
		private function tryQuit():void
		{
			this.close(QUIT_GAME);
			
			//TODO
			//this.setSubState(new Dialog("Are you sure you want to quit?", yes, no));
			//this.quit(null, yes);
		}
		
		/*
		private const yes:String = "Yes";
		private const no:String = "No";
		
		private function quit(state:FlxSubState, result:String):void
		{
			if (result == yes)
			{
				this.close(QUIT_GAME);
			}
		}*/

	}
}
