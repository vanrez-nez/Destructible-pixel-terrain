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
	
	public function new() {
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
			
			for ( obj in objects ) {
				obj.vY += 980 * DELTA_TIME_SEC;
				obj.x += obj.vX * DELTA_TIME_SEC;
				obj.y += obj.vY * DELTA_TIME_SEC;
				obj.checkConstrains( terrain );
			}
			
		}
	}
	
}