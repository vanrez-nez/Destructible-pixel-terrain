package terrain;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Graphics;
import openfl.geom.Matrix;
import openfl.geom.Point;
import src.terrain.definitions.IDrawable;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Ivan Juarez
 */
class Renderer extends Bitmap {
	
	private var objects: Array<IDrawable>;
	public var dest: Point;	
	
	public function new( width: Int, height: Int ) {
		super( new BitmapData( width, height ) );
		objects = [];
		dest = new Point( 0, 0 );
	}
	
	private function draw() {
		
		var idx = objects.length;
		while ( idx-- > 0 ) {
			
			var obj = objects[ idx ];
			
			if ( obj.disposed ) {
				remove( obj );
				
			} else {
				obj.update();
				obj.drawTo( this.bitmapData );
			}
			
		}
	}
	
	public function render() {
		bitmapData.lock();
		bitmapData.fillRect( bitmapData.rect, 0 );
		draw();
		bitmapData.unlock();
	}
	
	public function add( obj: IDrawable ) {
		objects.push( obj );
	}
	
	public function remove( obj: IDrawable ) {
		objects.remove( obj );
	}
}