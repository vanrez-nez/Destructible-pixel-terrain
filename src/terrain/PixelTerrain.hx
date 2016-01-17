package src.terrain;

import lime.math.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.utils.ByteArray;
import src.terrain.definitions.IDrawable;
import openfl.Assets;

/**
 * ...
 * @author Ivan Juarez
 */
class PixelTerrain implements IDrawable {
	private var aData: ByteArray;
	private var bitmapData: BitmapData;
	private var destructionRes: Int;
	
	public function new(imgPath: String, destructionRes: Int) {
		this.destructionRes = destructionRes;
		
		bitmapData = Assets.getBitmapData(imgPath);
		aData = bitmapData.getPixels(bitmapData.rect);
		
		var size: Int = bitmapData.width * bitmapData.height * 4;
		
		// optimal solution for drawing on each frame
		// http://stackoverflow.com/questions/10157787/haxe-nme-fastest-method-for-per-pixel-bitmap-manipulation
		var i: Int = 0;
		while (i < size){
			var r = aData[i + 0];
			var g = aData[i + 1];
			var b = aData[i + 2];
			if ((r == 255) && (g == 0) && (b == 255)) {
				aData[i + 0] = 0;
				aData[i + 2] = 0;
				aData[i + 3] = 0;
			}
			i += 4;
		}
		aData.position = 0;
		bitmapData.setPixels(bitmapData.rect, aData);
	}
	
	public function drawTo(bd: BitmapData): Void {
		bd.draw(bitmapData);
	}
	
	public function update(): Void {
		
	}
	
	
}