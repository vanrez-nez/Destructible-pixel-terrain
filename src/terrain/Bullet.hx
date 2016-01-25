package terrain;

import flash.geom.Rectangle;
import openfl.display.BitmapData;
import src.terrain.definitions.IDrawable;
import terrain.definitions.IPhysicsEntity;
import terrain.Physics;

/**
 * ...
 * @author Ivan Juarez
 */
class Bullet implements IDrawable implements IPhysicsEntity {
	
	public var x: Float;
	public var y: Float;
	public var vX: Float;
	public var vY: Float;
	public var lastX: Float;
	public var lastY: Float;
	public var disposed: Bool;
	private var color: Int;
	
	public function new( x: Float, y: Float, vX: Float, vY: Float ) {
		this.x = x;
		this.y = y;
		this.vX = vX;
		this.vY = vY;
		this.lastX = x;
		this.lastY = y;
		this.color = 0xFFFFFF00;
		this.disposed = false;
	}
	
	public function checkConstrains( terrain: PixelTerrain ) {
		var collision = Physics.Raycast( Std.int( lastX ), Std.int( lastY ), Std.int ( x ), Std.int ( y ), terrain );
		if ( collision.length > 0 ) {
			disposed = true;
			terrain.explode( collision[ 2 ], collision[ 3 ], 50 ); 
		}
		
		lastX = x;
		lastY = y;
	}
	
	public function drawTo( bd: BitmapData ): Void {
	
		//bd.setPixel( Std.int( x ), Std.int( y ), color );
		
		bd.fillRect( new Rectangle( x - 2, y - 2, 4, 4), color );
	}
	
	public function update(): Void {
		
	}
	
}