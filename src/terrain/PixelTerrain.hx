package terrain;

import lime.math.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.utils.ByteArray;
import src.terrain.definitions.IDrawable;
import openfl.events.MouseEvent;
import openfl.Assets;
import openfl.Lib;
import openfl.Memory;

/**
 * ...
 * @author Ivan Juarez
 */
class PixelTerrain implements IDrawable {
	private var bitmapData: BitmapData;
	private var destructionRes: Int;
	public var width(get, never): Int;
	public var height(get, never): Int;
	
	public function new(imgPath: String, destructionRes: Int) {
		this.destructionRes = destructionRes;
		processMapMask(imgPath);
	}
	
	private function processMapMask(imgPath: String) {
		var mask = 0xFFFF00FF; // argb(255, 255, 0, 255)
		var bdOrigin:BitmapData = Assets.getBitmapData(imgPath);
		bitmapData = new BitmapData(bdOrigin.width, bdOrigin.height, true, 0);
		bitmapData.lock();
		for (x in 0...width) {
			for (y in 0...height) {
				var pixel = bdOrigin.getPixel32(x, y);
				if (pixel == mask) {
					bitmapData.setPixel32(x, y, 0);
				} else {
					bitmapData.setPixel32(x, y, pixel);
				}
			}
		}
		bitmapData.unlock();
	}
	
	public function drawTo(bd: BitmapData): Void {
		bd.draw(bitmapData);
	}
	
	public function update(): Void {
		
	}
	
	private inline function getPixel(x: Int, y: Int): Int {
		if (x > 0 && x < width && y > 0 && y < height) {
			return bitmapData.getPixel32(x, y);
		} else {
			return 0;
		}
	}
	
	private inline function setPixel(x: Int, y: Int, color: Int) {
		if (x > 0 && x < width && y > 0 && y < height) {
			bitmapData.setPixel(x, y, color);
		}
	}
	
	public function isPixelSolid(x: Int, y: Int ): Bool {
		return getPixel(x, y) != 0;
	}
	
	public function addPixel(x: Int, y: Int, color: Int) {
		setPixel(x, y, color);
	}
	
	public function removePixel(x: Int, y: Int) {
		setPixel(x, y, 0);
	}
	
	public function getColor(x: Int, y: Int): Int {
		return getPixel(x, y);
	}
	
	public function getNormal(x: Int, y: Int): Array<Float> {
		var avgX: Float = 0;
		var avgY: Float = 0;
		for (w in -3...3) {
			for (h in -3...3) {
				if (isPixelSolid(x + w, y + h)) {
					avgX = -w;
					avgY = -h;
				}
			}
		}
		var len = Math.sqrt(avgX * avgX + avgY * avgY);
		return [avgX/len, avgY/len];
	}
	
	public function get_width() return bitmapData.width;
	public function get_height() return bitmapData.height;
	
	
}