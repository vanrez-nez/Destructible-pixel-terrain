package;

import openfl.display.Sprite;
import openfl.Lib;
import flash.events.Event;
import src.terrain.TerrainScene;
import tools.Stats;
/**
 * ...
 * @author Ivan Juarez
 */
class Main extends Sprite 
{
	private var terrainScene: TerrainScene;
	private var initialized: Bool;
	
	public function resize(?e:Event) {
		if (!initialized) init();
	}
	
	private function init() {
		if (initialized) return;
		initialized = true;
		terrainScene = new TerrainScene();
		addChild(terrainScene);
		addChild(new Stats());
	}
	
	public function onAddedToStage(e) {
		resize();
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		stage.addEventListener(Event.RESIZE, resize);
		stage.addEventListener(Event.ENTER_FRAME, update);
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
	}

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function update(e: Event) {
		terrainScene.update(e);
		
	}

}
