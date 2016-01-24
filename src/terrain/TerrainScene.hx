package terrain;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;
import openfl.Assets;
import terrain.Player;
import terrain.Renderer;
import terrain.PixelTerrain;
import terrain.Controls;
import terrain.Physics;

import openfl.events.MouseEvent;
import openfl.Lib;

/**
 * ...
 * @author Ivan Juarez
 */
class TerrainScene extends Sprite {
	
	
	private var renderer: Renderer;
	private var player: Player;
	private var controls: Controls;
	private var cloudsBackground: Bitmap;
	private var pixelTerrain: PixelTerrain;
	private var physics: Physics;
	public var bitmap: Bitmap;
	
	public function new() {
		super();
		init();
	}
	
	public function init() {
		
		cloudsBackground = new Bitmap(Assets.getBitmapData('img/clouds.png'));
		this.addChild(cloudsBackground);
		
		renderer = new Renderer(1024, 500);
		this.addChild(renderer);
		
		pixelTerrain = new PixelTerrain('img/more-trees.png', 2);
		//pixelTerrain.normalsVisible = true;
		renderer.add(pixelTerrain);
		
		player = new Player(15, 25);
		renderer.add(player);
		
		physics = new Physics();
		physics.add(player);
		
		controls = new Controls();
		controls.addPlayer(player);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	private function onMouseDown(e: MouseEvent) {
		trace(pixelTerrain.isPixelSolid(Std.int(e.stageX), Std.int(e.stageY)));
	}
	
	public function update(e: Event) {
		physics.update( pixelTerrain );
		renderer.render();
	}
	
}