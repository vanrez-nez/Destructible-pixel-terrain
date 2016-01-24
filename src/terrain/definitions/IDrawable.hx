package src.terrain.definitions;
import openfl.display.BitmapData;

/**
 * @author Ivan Juarez
 */
interface IDrawable {
	public function drawTo(bitmapData: BitmapData): Void;
	public function update(): Void;
	public var disposed: Bool;
}