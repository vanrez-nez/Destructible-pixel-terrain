package terrain;

import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
import src.terrain.definitions.IDrawable;
import openfl.Memory;

/**
 * ...
 * @author Ivan Juarez
 */

class Player implements IDrawable {
	
	public static var DIRECTION_LEFT = -1;
	public static var DIRECTION_RIGHT = 1;
	public static var DIRECTION_NONE = 0;
	
	private var dimensions: Rectangle;
	private var clipRect: Rectangle;
	private var bitmapData:BitmapData;
	private var dirty: Bool;
	private var posX: Float;
	private var posY: Float;
	private var velX: Float;
	private var velY: Float;
	private var walkingDirection: Int;
	private var shooting: Bool;
	private var shootingAlt: Bool;
	private var onGround: Bool;
	private var transform: Matrix;
	
	private var colorModifier = 0;
	
	public function new(width: Int = 10, height: Int = 10) {
		dimensions = new Rectangle(0, 0, width, height);
		posX = 0;
		posY = 0;
		velX = 0;
		velY = 0;
		dirty = true;
		onGround = false;
	}
	
	public function drawTo(bd: BitmapData): Void {
		
		//bitmapData.lock();
		
		var color = Std.int(Math.random() * 0x1000000);
		for (idx in 0...10000) {
			bd.setPixel32(Std.int(Math.random() * 1024), Std.int(Math.random() * 768), 0xFFFFFFFF);
		}
		//bitmapData.unlock();
		//bd.draw(bitmapData, new Matrix(1, 0, 0, 1, posX, posY));
		//bd.copyPixels(bitmapData, dimensions, new Point(posX, posY));
		//aData.position = 0;
		//bd.setPixels(dimensions, aData);
	}
	
	public function update(): Void {
		if (dirty) {
			var color = Std.int(Math.random() * 0x1000000);
			//posX = Math.random() * 1024;
			//posY = Math.random() * 768;
			//bitmapData.fillRect(dimensions, color);
			dirty = false;
		}
	}
	
	public function jump() {
		
	}
	
	public function shoot(active: Bool) {
		shooting = active;
		dirty = true;
	}
	
	public function shootAlt(active: Bool) {
		shootingAlt = active;
	}
		
	public function walkTo(direction: Int) {
		posX += direction;
	}
	
}