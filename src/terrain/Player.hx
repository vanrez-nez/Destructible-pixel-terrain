package src.terrain;

import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import src.terrain.definitions.IDrawable;

/**
 * ...
 * @author Ivan Juarez
 */
class Player implements IDrawable {
	
	private var dimensions: Rectangle;
	private var bitmapData:BitmapData;
	private var dirty: Bool;
	private var position: Point;
	private var velocity: Point;
	
	
	public function new(width: Int = 10, height: Int = 10) {
		dimensions = new Rectangle(0, 0, width, height);
		bitmapData = new BitmapData(width, height, false);
		position = new Point();
		velocity = new Point();
		dirty = true;
	}
	
	public function drawTo(bd: BitmapData): Void {
		bd.draw(bitmapData);
	}
	
	public function update(): Void {
		if (dirty) {
			var color = Std.int(Math.random() * 0x1000000);
			bitmapData.fillRect(dimensions, color);
			dirty = false;
		}
	}
	
}