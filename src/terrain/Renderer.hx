package terrain;
import openfl.display.BitmapData;
import openfl.display.Graphics;
import openfl.geom.Matrix;
import terrain.definitions.IDrawable;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Ivan Juarez
 */
class Renderer {
	
	private var objects: Array<IDrawable>;
	public var bitmapData: BitmapData;
	
	public function new(width: Int, height: Int) {
		objects = [];
		bitmapData = new BitmapData(width, height, false);
	}
	
	private function update() {
		for (obj in objects) {
			obj.update();
		}
	}
	
	private function draw() {
		for (obj in objects) {
			obj.drawTo(bitmapData);
		}
	}
	
	public function render(graphics: Graphics) {
		update();
		draw();
		
		//graphics.clear();
		graphics.beginBitmapFill(bitmapData);
		graphics.drawRect(0, 0, bitmapData.width, bitmapData.height);
		//graphics.endFill();
	}
	
	public function add(obj: IDrawable) {
		objects.push(obj);
	}
	
	public function remove(obj: IDrawable) {
		objects.remove(obj);
	}
	
}