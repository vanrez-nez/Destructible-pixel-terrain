package src.terrain;

import lime.math.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Sprite;
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
	private var aData: ByteArray;
	private var bitmapData: BitmapData;
	private var bdOrigin: BitmapData;
	private var destructionRes: Int;
	public var width(get, never): Int;
	public var height(get, never): Int;
	
	public function new(imgPath: String, destructionRes: Int) {
		this.destructionRes = destructionRes;
		bdOrigin = Assets.getBitmapData(imgPath);
		bitmapData = new BitmapData(bdOrigin.width, bdOrigin.height, true, 0xFF);
		aData = bdOrigin.getPixels(bdOrigin.rect);
		
		processMapMask();		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
	}
	
	private function processMapMask() {
		var mask = 0xFFFF00FF; // argb(255, 255, 0, 255)
		#if flash
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
		#else
			// optimal solution for drawing on each frame (cpp)
			// Memory in Flash comes with big-endian so its not compatible?
			// http://stackoverflow.com/questions/10157787/haxe-nme-fastest-method-for-per-pixel-bitmap-manipulation
			Memory.select(aData);
			for (idx in 0...(width * height)) {
				var pixel:Int = Memory.getI32(idx << 2);
				if (pixel == mask) {
					Memory.setI32(idx << 2, 0);
				} else {
					Memory.setI32(idx << 2, pixel);
				}
			}
			aData.position = 0;
			bitmapData.setPixels(bitmapData.rect, aData);
		#end
		
	}
	
	private function onMouseClick(e: MouseEvent) {
		trace(e.stageX, e.stageY, isPixelSolid(Std.int(e.stageX), Std.int(e.stageY)));
	}
	
	public function drawTo(bd: BitmapData): Void {
		bd.draw(bitmapData);
	}
	
	public function update(): Void {
		
	}
	
	private inline function getPixel(x: Int, y: Int): Int {
		#if flash
		return bitmapData.getPixel32(x, y);
		#else
		return Memory.getI32((y * width + x) << 2);
		#end
	}
	
	public function isPixelSolid(x: Int, y: Int ): Bool {
		if (x > 0 && x < width && y > 0 && y < height) {
			return getPixel(x, y) != 0;
		}
		
		return false;
	}
	
	
	
	public function get_width() return bitmapData.width;
	public function get_height() return bitmapData.height;
	
	
}