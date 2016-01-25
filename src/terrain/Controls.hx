package terrain;

import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Ivan Juarez
 */
class Controls {
	private var player: Player;
	public var mouseX: Float;
	public var mouseY: Float;
	
	public function new() {
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseUpDown );
		Lib.current.stage.addEventListener( MouseEvent.RIGHT_MOUSE_DOWN, onMouseUpDown );
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUpDown );
		Lib.current.stage.addEventListener( MouseEvent.RIGHT_MOUSE_UP, onMouseUpDown );
		
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		mouseX = 0;
		mouseY = 0;
	}
	
	private function onKeyDown(e: KeyboardEvent) {
		
		if ( e.keyCode == Keyboard.W ) {
			player.jump();
		}
		
		if ( e.keyCode == Keyboard.A ) {
			player.walkTo( Player.DIRECTION_LEFT );
		}
		
		if ( e.keyCode == Keyboard.D ) {
			player.walkTo( Player.DIRECTION_RIGHT );
		}
	}
	
	private function onKeyUp( e: KeyboardEvent ) {
		if ( e.keyCode == Keyboard.A || e.keyCode == Keyboard.D ) {
			player.walkTo( Player.DIRECTION_NONE );
		}
	}
	
	private function onMouseUpDown(e: MouseEvent) {
		player.setShootTargetTo( e.stageX, e.stageY );
		player.shoot( e.type == MouseEvent.MOUSE_DOWN );
		player.shootAlt( e.type == MouseEvent.RIGHT_MOUSE_DOWN );
	}
	
	private function onMouseMove( e: MouseEvent ) {
		mouseX = e.stageX;
		mouseY = e.stageY;
	}
	
	public function addPlayer( player: Player ) {
		this.player = player;
	}
	
}