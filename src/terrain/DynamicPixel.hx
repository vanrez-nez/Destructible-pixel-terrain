package terrain;
import src.terrain.definitions.IDrawable;
import terrain.definitions.IPhysicsEntity;

/**
 * ...
 * @author Ivan Juarez
 */
class DynamicPixel implements IDrawable implements IPhysicsEntity {
	
	public static inline STICKINESS = 1500;
	public static inline BOUNCE_DAMPING = 0.85;
	
	public var x: Float;
	public var y: Float;
	public var vX: Float;
	public var vY: Float;
	
	public function new() {
		
	}
	
	public function checkConstrains( terrain: PixelTerrain ) {
		
	}
	
	public function drawTo( bd: BitmapData ): Void {
	
	}
	
	public function update(): Void {
	
	}
}