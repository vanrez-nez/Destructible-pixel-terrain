package terrain;

import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import src.terrain.definitions.IDrawable;
import terrain.definitions.IPhysicsEntity;
import terrain.PixelTerrain;

/**
 * ...
 * @author Ivan Juarez
 */

class Player implements IDrawable implements IPhysicsEntity {
	
	public static var DIRECTION_LEFT = -1;
	public static var DIRECTION_RIGHT = 1;
	public static var DIRECTION_NONE = 0;
	
	private var bitmapData:BitmapData;
	private var transform: Matrix;

	private var dirty: Bool;
	public var x: Float;
	public var y: Float;
	public var vX: Float;
	public var vY: Float;
	public var onGround: Bool;
	
	private var width(get, never): Float;
	private var height(get, never): Float;
	
	private var walkingDirection: Int;
	private var shooting: Bool;
	private var shootingAlt: Bool;
	
	
	public function new(width: Int = 10, height: Int = 10) {
		bitmapData = new BitmapData(width, height, false);
		transform = new Matrix();
		x = 0;
		y = 0;
		vX = 0;
		vY = 0;
		dirty = true;
		onGround = false;
	}
	
	public function drawTo(bd: BitmapData): Void {
		bd.draw(bitmapData, transform);
	}
	
	public function update(): Void {
		if (dirty) {
			transform.tx = x;
			transform.ty = y;
			bitmapData.fillRect(new Rectangle(0, 0, width, height), 0xFFF);
			dirty = false;
		}
	}
	
	public function jump() {
		dirty = true;
	}
	
	public function shoot(active: Bool) {
		shooting = active;
		dirty = true;
	}
	
	public function shootAlt(active: Bool) {
		shootingAlt = active;
	}
		
	public function walkTo(direction: Int) {
		walkingDirection = direction;
		dirty = true;
	}
	
	public function checkConstrains( terrain: PixelTerrain ) {
		dirty = true;
		
		// update movement
		vX *= 0.8;
		if ( vX > -500 && vX < 500 )
			vX += 40 * walkingDirection;
		
		// Player pixel collision detection against terrain
		onGround = false;
		var height4 = height / 4;

		for ( pX in Std.int( x )...Std.int( x + width ) ) {
			if ( terrain.isPixelSolid( pX, Std.int( y + height ) ) && vY > 0 ) {
				onGround = true;
				var pY = Std.int( y + height * 0.75);
				while ( pY++ < y + height ) {
					if ( terrain.isPixelSolid( pX, pY ) ) {
						y = pY - height;
						break;
					}
				}
				if (vY > 0)
					vY *= -0.25;
			}
		}
			
		// screen boundary checks
		if ( vX != 0 ) {
			
			if ( x + width > terrain.width ) {
				x = terrain.width - width;
				vX *= -1;
			}
		
			if ( x < 0 ) {
				x = 0;
				vX *= -1;
			}
		}
		
		if ( y + height > terrain.height && vY > 0 ) {
			y = terrain.height - height;
			vY = 0;
			onGround = true;
		}
		
		update();
	}
	
	public function get_width(): Float {
		return this.bitmapData.width;
	}
	
	public function get_height(): Float {
		return this.bitmapData.height;
	}
	
}