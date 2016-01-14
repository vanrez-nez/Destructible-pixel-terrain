package terrain;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import terrain.definitions.IDrawable;

/**
 * ...
 * @author Ivan Juarez
 */
class Player implements IDrawable {
	
	private var rect: Rectangle;
	
	public function new(width: Int = 10, height: Int = 10) {
		rect = new Rectangle(0, 0, width, height);
	}
	
	public function drawTo(bd: BitmapData): Void {
		//bd.fillRect(rect, 0xFFF);
		var color = Std.int(Math.random() * 0x1000000);
		for (i in 0...1024) {
			for (j in 0...768) {
					bd.setPixel32(i, j, color);
			}
		}
	}
	
	public function update(): Void {
		
	}
	
}