package terrain;

import haxe.Timer;
import terrain.definitions.IPhysicsEntity;
import terrain.Player;
import terrain.PixelTerrain;

/**
 * ...
 * @author Ivan Juarez
 */
class Physics {
	static inline var DELTA_TIME_MS = 1000 / 60;
	static inline var DELTA_TIME_SEC = DELTA_TIME_MS / 1000;
	
	private var previousTime: Float;
	private var currentTime: Float;
	private var leftOverDeltaTime: Float;
	
	private var objects: Array<IPhysicsEntity>;
	
	public function new( ) {
		objects = [];
		currentTime = 0;
		previousTime = 0;
		leftOverDeltaTime = 0;
	}
	
	public function add(object: IPhysicsEntity) {
		objects.push( object );
	}
	
	public function remove(object: IPhysicsEntity) {
		objects.remove( object );
	}
	
	public function update( terrain: PixelTerrain ) {
		currentTime = Std.int( Timer.stamp() * 1000 );
		var delta = currentTime - previousTime;
		previousTime = currentTime;
		
		var timeSteps: Float = Std.int( delta + leftOverDeltaTime / DELTA_TIME_MS );
		timeSteps = Math.min( timeSteps, 1 );
		
		leftOverDeltaTime = Std.int( delta - ( timeSteps * DELTA_TIME_MS ) );
		
		var steps = 0;
		while ( steps++ < timeSteps ) {
			
			var idx = objects.length;
			while ( idx-- > 0 ) {
				var obj = objects[ idx ];
			
				if ( obj.disposed ) {
					remove( obj );
					
				} else {
					obj.vY += 980 * DELTA_TIME_SEC;
					obj.x += obj.vX * DELTA_TIME_SEC;
					obj.y += obj.vY * DELTA_TIME_SEC;
					obj.checkConstrains( terrain );
				}
			}
			
		}
	}
	
	public static function Raycast( xFrom: Int, yFrom: Int, xTo: Int, yTo: Int, terrain: PixelTerrain ): Array<Int> {
		
		var deltaX = Std.int( Math.abs( xTo - xFrom ) ),
			deltaY = Std.int( Math.abs( yTo - yFrom ) );
		
		var xInc1 = xTo >= xFrom ? 1 : -1,
			yInc1 = xTo >= xFrom ? 1 : -1,
			xInc2 = yTo >= yFrom ? 1 : -1,
			yInc2 = yTo >= yFrom ? 1 : -1;
		
		var den, num, numAdd, pixelsCount;

		if ( deltaX >= deltaY ) {
			xInc1 = 0;
			yInc2 = 0;
			den = deltaX;
			num = deltaY / 2;
			numAdd = deltaY;
			pixelsCount = deltaX;
			
		} else {
			yInc1 = 0;
			xInc2 = 0;
			den = deltaY;
			num = deltaY;
			numAdd = deltaX;
			pixelsCount = deltaY;
			
		}
		
		var prevX = xFrom,
			prevY = yFrom,
			x = xFrom,
			y = yFrom;
			
		for (cPixel in 0...pixelsCount + 1 ) {
			
			if ( terrain.isPixelSolid( x, y ) )
				return [ prevX, prevY, x, y ];
			
			prevX = x;
			prevY = y;
			
			num += numAdd;
			
			if ( num >= den ) {
				num -= den;
				x += xInc1;
				y += yInc1;
			}
			
			x += xInc2;
			y += yInc2;
			
		}
		
		return [];		
	}
	
}