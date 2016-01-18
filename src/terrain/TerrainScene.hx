package src.terrain;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Rectangle;
import src.terrain.Player;
import src.terrain.Renderer;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;
import openfl.Assets;

/**
 * ...
 * @author Ivan Juarez
 */
class TerrainScene extends Sprite {
	
	
	private var renderer: Renderer;
	private var player: Player;
	private var cloudsBackground: Bitmap;
	private var pixelTerrain: PixelTerrain;
	public var bitmap: Bitmap;
	
	public function new() {
		super();
		init();
	}
	
	public function init() {
		
		cloudsBackground = new Bitmap(Assets.getBitmapData('img/clouds.jpg'));
		this.addChild(cloudsBackground);
		
		renderer = new Renderer(1284, 696);
		this.addChild(renderer);
		pixelTerrain = new PixelTerrain('img/more-trees.png', 2);
		trace(pixelTerrain.width);
		renderer.add(pixelTerrain);
		player = new Player(10, 30);
		renderer.add(player);
	}
	
	public function update(e: Event) {
		renderer.render();
	}
	
}