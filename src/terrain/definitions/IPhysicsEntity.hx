package terrain.definitions;
import terrain.PixelTerrain;
/**
 * @author Ivan Juarez
 */
interface IPhysicsEntity {
	public var x: Float;
	public var y: Float;
	public var vX: Float;
	public var vY: Float;
	public function checkConstrains(terrain: PixelTerrain): Void;
}