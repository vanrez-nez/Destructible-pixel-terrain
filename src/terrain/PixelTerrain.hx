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
	private var normalsSprite: Sprite;
	private var destructionRes: Int;
	public var normalsVisible: Bool;
	public var normalsDirty: Bool;
	public var width(get, never): Int;
	public var height(get, never): Int;
	
	public function new(imgPath: String, destructionRes: Int) {
		this.destructionRes = destructionRes;
		normalsSprite = new Sprite();
		normalsVisible = false;
		normalsDirty = true;
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
		if (normalsVisible) {
			bd.draw(normalsSprite);
		}
	}
	
	public function update(): Void {
		this.updateNormals();
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
			bitmapData.setPixel32(x, y, color);
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
	
	private function getNormal(x: Int, y: Int): Array<Float> {
		var avgX: Float = 0;
		var avgY: Float = 0;
		for (w in -3...4) {
			for (h in -3...4) {
				if (isPixelSolid(x + w, y + h)) {
					avgX -= w;
					avgY -= h;
				}
			}
		}
		var len = Math.sqrt(avgX * avgX + avgY * avgY);
		return [avgX/len, avgY/len];
	}
	
	
	private function updateNormals() {
		if (! normalsDirty) {
			return;
		}
		
		var graphics = normalsSprite.graphics;
		graphics.clear();
		graphics.beginFill(0x0000FF);
		graphics.lineStyle(2, 0xFFFF00, 1);
		var x = 0;
		var y = 0;
		graphics.drawCircle(200, 500, 10);
		while (x < width) {
			
			while(y < height) {
				
				var solidCount = 0;
				
				for (i in -5...6) {
					for (j in -5...6) {
						
						if (isPixelSolid(x + i, y + j)) {
							solidCount++;
						}
						
					}
				}
				
				
				if (solidCount < 110 && solidCount > 30) {
					var pixelNormal: Array<Float> = getNormal(x, y);
					trace(x, y, x + 10 * pixelNormal[0],  y + 10 * pixelNormal[1]);
					graphics.moveTo(x, y);
					graphics.lineTo(x + 10 * pixelNormal[0], y + 10 * pixelNormal[1]);
				}
				y += 10;
			}
			x += 10;
		}
		graphics.endFill();
		normalsDirty = false;
	}
	
	public function get_width() return bitmapData.width;
	public function get_height() return bitmapData.height;
	
	
}