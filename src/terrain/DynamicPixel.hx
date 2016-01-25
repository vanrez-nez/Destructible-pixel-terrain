package terrain;

import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import src.terrain.definitions.IDrawable;
import terrain.definitions.IPhysicsEntity;
import terrain.PixelTerrain;

/**
 * ...
 * @author Ivan Juarez
 */
class DynamicPixel implements IDrawable implements IPhysicsEntity {
	
	public static var STICKINESS = 900 * 900;
	public static var BOUNCE_DAMPING = 0.75;
	
	public var x: Float;
	public var y: Float;
	public var vX: Float;
	public var vY: Float;
	public var lastX: Float;
	public var lastY: Float;
	public var disposed: Bool;
	
	private var color: Int;
	private var size: Int;
	
	public function new( x: Float, y: Float, vX: Float, vY: Float, color: Int, size: Int ) {
		this.x = x;
		this.y = y;
		this.vX = vX;
		this.vY = vY;
		this.color = color;
		this.size = size;
		this.lastX = x;
		this.lastY = y;
		this.disposed = false;
	}
	
	public function checkConstrains( terrain: PixelTerrain ) {
		
		var collision = Physics.Raycast( 
			Std.int( lastX ),
			Std.int( lastY ),
			Std.int( x ),
			Std.int( y ),
			terrain
		);
		
		if ( collision.length > 0 )
			collide( collision, terrain );
		
		lastX = x;
		lastY = y;
		
		if (x < 0 || x > terrain.width || y > terrain.height) {
			disposed = true;
		}
	}
	
	private function collide( collision: Array<Int>, terrain: PixelTerrain) {
		
		var x1 = collision[0],
			y1 = collision[1],
			x2 = collision[2],
			y2 = collision[3];
			
		if ( vX * vX + vY * vY < STICKINESS ) {
			for ( cX in 0...size ) {
				for ( cY in 0...size ) {
					terrain.addPixel( x1 + cX, y1 + cY, color );
				}
			}
			
			disposed = true;
			
		} else {
			
			var normal = terrain.getNormal( x2, y2 );
			var projection = 2 * ( vX * normal[ 0 ] + vY * normal[ 1 ] );
			vX -= normal[ 0 ] * projection;
			vY -= normal[ 1 ] * projection;
			vX *= BOUNCE_DAMPING;
			vY *= BOUNCE_DAMPING;
			x = x1;
			y = y1;
		}
	}
	
	public function drawTo( bd: BitmapData ): Void {
		bd.fillRect( new Rectangle( x - 1, y - 1, 2, 2), color );
		//bd.setPixel( Std.int( x ), Std.int( y ), color );
	}
	
	public function update(): Void {
		
	}
}