package src.terrain;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Graphics;
import openfl.geom.Matrix;
import openfl.geom.Point;
import src.terrain.definitions.IDrawable;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Ivan Juarez
 */
class Renderer extends Bitmap {
	
	private var objects: Array<IDrawable>;
	public var rectSize: Rectangle;
	public var dest: Point;
	
	
	public function new(width: Int, height: Int) {
		super(new BitmapData(width, height, true, 0xFF));
		objects = [];
		
		this.rectSize = new Rectangle(0, 0, width, height);
		dest = new Point(0, 0);
	}
	
	private function update() {
		for (obj in objects) {
			obj.update();
		}
	}
	
	private function draw() {
		for (obj in objects) {
			obj.drawTo(this.bitmapData);
		}
	}
	
	public function render() {
		update();
		draw();
	}
	
	public function add(obj: IDrawable) {
		objects.push(obj);
	}
	
	public function remove(obj: IDrawable) {
		objects.remove(obj);
	}
	
}