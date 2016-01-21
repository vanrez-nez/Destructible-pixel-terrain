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
	private var bitmapData:BitmapData;
	private var transform: Matrix;

	private var dirty: Bool;
	private var posX: Float;
	private var posY: Float;
	private var velX: Float;
	private var velY: Float;
	private var walkingDirection: Int;
	private var shooting: Bool;
	private var shootingAlt: Bool;
	private var onGround: Bool;
	
	private var colorModifier = 0;
	
	public function new(width: Int = 10, height: Int = 10) {
		dimensions = new Rectangle(0, 0, width, height);
		bitmapData = new BitmapData(width, height, false);
		transform = new Matrix();
		posX = 0;
		posY = 0;
		velX = 0;
		velY = 0;
		dirty = true;
		onGround = false;
	}
	
	public function drawTo(bd: BitmapData): Void {
		bd.draw(bitmapData, transform);
	}
	
	public function update(): Void {
		if (dirty) {
			transform.tx = posX;
			transform.ty = posY;
			bitmapData.fillRect(dimensions, 0xFFF);
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
		dirty = true;
	}
	
}