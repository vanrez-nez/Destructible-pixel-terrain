package src.terrain;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Rectangle;
import terrain.Player;
import terrain.Renderer;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;



/**
 * ...
 * @author Ivan Juarez
 */
class TerrainScene extends Sprite {
	
	
	private var renderer: Renderer;
	private var player: Player;
	public var bitmapData: BitmapData;
	
	
	public function new() {
		super();
		init();
		
	}
	
	public function init() {
		renderer = new Renderer(1024, 768);
		player = new Player(10, 10);
		renderer.add(player);
	}
	
	public function update(e: Event) {
		renderer.render(graphics);
	}
	
}