package terrain.definitions;
import terrain.PixelTerrain;
/**
 * @author Ivan Juarez
 */
interface IPhysicsEntity {
	public var posX(default, set): Float;
	public var posY(default, set): Float;
	public var velX(default, default): Float;
	public var velY(default, default): Float;
	public function checkConstrains(terrain: PixelTerrain): Void;
}