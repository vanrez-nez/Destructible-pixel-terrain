package;

import openfl.display.Sprite;
import openfl.Lib;
import flash.events.Event;

/**
 * ...
 * @author Ivan Juarez
 */
class Main extends Sprite 
{
	private var initialized: Bool;
	
	public function resize(?e:Event) {
		if (!initialized) init();
	}
	
	private function init() {
		if (initialized) return;
		initialized = true;
	}
	
	public function onAddedToStage(e) {
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		stage.addEventListener(Event.RESIZE, resize);
		stage.addEventListener(Event.ENTER_FRAME, update);
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		resize();
	}

	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}
	
	public function update(e: Event) {
		
	}

}
