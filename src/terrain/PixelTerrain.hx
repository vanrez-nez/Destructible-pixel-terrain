package terrain;

import openfl.display.BitmapData;
import openfl.display.Sprite;
import src.terrain.definitions.IDrawable;
import terrain.definitions.Delegates;
import openfl.Assets;
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
	public var disposed: Bool;
	
	public var addDynamicPixelDelegate: TDynamicPixelDelegate;
	
	public var width( get, never ): Int;
	public var height( get, never ): Int;
	
	public function new( imgPath: String, destructionRes: Int ) {
		this.destructionRes = destructionRes;
		normalsSprite = new Sprite();
		normalsVisible = false;
		normalsDirty = true;
		disposed = false;
		processMapMask( imgPath );
	}
	
	private function processMapMask( imgPath: String ) {
		var mask = 0xFFFF00FF; // argb(255, 255, 0, 255)
		var bdOrigin:BitmapData = Assets.getBitmapData( imgPath );
		bitmapData = new BitmapData( bdOrigin.width, bdOrigin.height, true, 0 );
		bitmapData.lock();
		for ( x in 0...width ) {
			for ( y in 0...height ) {
				var pixel = bdOrigin.getPixel32( x, y );
				if ( pixel == mask ) {
					bitmapData.setPixel32( x, y, 0 );
				} else {
					bitmapData.setPixel32( x, y, pixel );
				}
			}
		}
		bitmapData.unlock();
	}
	
	public function drawTo( bd: BitmapData ): Void {
		bd.draw( bitmapData );
		if ( normalsVisible ) {
			bd.draw( normalsSprite );
		}
	}
	
	public function update(): Void {
		this.updateNormals();
	}
	
	private inline function getPixel( x: Int, y: Int ): Int {
		if ( x >= 0 && x <= width && y >= 0 && y <= height ) {
			return bitmapData.getPixel32( x, y );
		} else {
			return 0;
		}
	}
	
	private inline function setPixel( x: Int, y: Int, color: Int ) {
		if ( x > 0 && x < width && y > 0 && y < height ) {
			bitmapData.setPixel32( x, y, color );
		}
	}
	
	public function isPixelSolid( x: Int, y: Int ): Bool {
		return getPixel( x, y ) != 0;
	}
	
	public function addPixel( x: Int, y: Int, color: Int ) {
		setPixel( x, y, color );
	}
	
	public function removePixel(x: Int, y: Int) {
		setPixel(x, y, 0);
	}
	
	public function getColor( x: Int, y: Int ): Int {
		return getPixel( x, y );
	}
	
	public function getNormal( x: Int, y: Int ): Array<Float> {
		var avgX: Float = 0;
		var avgY: Float = 0;
		for ( w in -3...4 ) {
			for ( h in -3...4 ) {
				if ( isPixelSolid( x + w, y + h ) ) {
					avgX -= w;
					avgY -= h;
				}
			}
		}
		var len = Math.sqrt( avgX * avgX + avgY * avgY );
		return [ avgX / len, avgY / len ];
	}
	
	
	private function updateNormals() {
		if (! normalsDirty ) {
			return;
		}
		
		var graphics = normalsSprite.graphics;
		graphics.clear();
		graphics.lineStyle( 2, 0xFFFF00, 1 );
		
		var x = 0;
		var y = 0;
		while ( x < width ) {
			y = 0;
			while( y < height ) {
				
				var solidCount = 0;
				
				for ( i in -5...6 ) {
					for ( j in -5...6 ) {
						
						if ( isPixelSolid( x + i, y + j ) ) {
							solidCount++;
						}
						
					}
				}
				
				if ( solidCount < 110 && solidCount > 30 ) {
					var pixelNormal: Array<Float> = getNormal( x, y );

					if (! Math.isNaN( pixelNormal[0] ) && ! Math.isNaN( pixelNormal[1] ) ) {
						//trace(x, y, x + 10 * pixelNormal[0],  y + 10 * pixelNormal[1]);
						graphics.moveTo( x, y );
						graphics.lineTo( x + 10 * pixelNormal[0], y + 10 * pixelNormal[1] );
					}
				}
				y += 10;
			}
			x += 10;
		}
		normalsDirty = false;
	}
	
	public inline function removePixelsRect( x: Int, y: Int, width: Int, height: Int ) {
		for ( cX in 0...width) {
			for ( cY in 0...height ) {
				removePixel( x + cX, y + cY );
			}
		}
	}
	
	public function explode( x: Int, y: Int, radius: Int ) {
		var radiusSqrt = radius * radius;
		
		var cX = x - radius;
		while ( cX < x + radius ) {
			if ( x > 0 &&  x < width ) {
				
				var cY = y - radius;
				while ( cY < y + radius ) {
					if ( cY > 0 && cY < height ) {
						
						var solid = false;
						var solidX = 0;
						var solidY = 0;
						for ( i in 0...destructionRes ) {
							for ( j in 0...destructionRes ) {
								if ( isPixelSolid( cX + i, cY + j ) ) {
									solid = true;
									solidX = cX + i;
									solidY = cY + j;
									break;
								}
							}
							if (solid) {
								break;
							}
						}
						
						if ( solid ) {
							
							var xDiff = cX - x;
							var yDiff = cY - y;
							var distSqrt = xDiff * xDiff + yDiff * yDiff;
							
							if ( distSqrt < radiusSqrt ) {
								var dist = Math.sqrt( distSqrt );
								var speed = 800 * ( 1 - dist / radius );
								
								dist = dist == 0 ? 0.001 : dist;
								var vX = speed * ( xDiff + ( Math.random() * 20 - 10 ) ) / dist;
								var vY = speed * ( yDiff + ( Math.random() * 20 - 10 ) ) / dist;
								addDynamicPixelDelegate( cX, cY, vX, vY, getColor( cX , cY ), destructionRes);
								removePixelsRect( cX, cY, destructionRes, destructionRes );
							}
							
						}
						
					}
					cY += destructionRes;
				}
				
			}
			cX += destructionRes;
		}
	}
	
	
	public function get_width() return bitmapData.width;
	public function get_height() return bitmapData.height;
	
	
}