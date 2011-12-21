package
{
	import ezplatformer.menus.MainMenu;
	import org.flixel.FlxGame;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	
	/**
	 * The platformer is based off of AdamAtomic's sample game:
	 * 	http://flashgamedojo.com/wiki/index.php?title=EZPlatformer_(Flixel)
	 * 	
	 * It has been modified to work together with the additional
	 *  "FlxSubState" system found on this branch:
	 *  https://github.com/IQAndreas/flixel/tree/dev_FlxSubState
	 *  
	 *  The included SWC is Flixel with modifications from that branch.
	 *  
	 *  The only two classes that extend "FlxSubState" are
	 *   - PauseMenu
	 *   - GameOverMenu
	 *   
	 *  The MainMenu is meant to be opened all on it's own, 
	 *   and is therefore not a FlxSubState.
	 */
	public class EZPlatformer extends FlxGame
	{
		public function EZPlatformer()
		{
			super(320,240,MainMenu,2);
			forceDebugger = true;
		}
	}
}
