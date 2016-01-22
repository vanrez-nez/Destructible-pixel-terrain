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
	
	public function new() {
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onMouseUp);
	}
	
	private function onKeyDown(e: KeyboardEvent) {
		
		if (e.keyCode == Keyboard.W) {
			player.jump();
		}
		
		if (e.keyCode == Keyboard.A) {
			player.walkTo(Player.DIRECTION_LEFT);
		}
		
		if (e.keyCode == Keyboard.D) {
			player.walkTo(Player.DIRECTION_RIGHT);
		}
	}
	
	private function onKeyUp(e: KeyboardEvent) {
		if (e.keyCode == Keyboard.A || e.keyCode == Keyboard.D) {
			player.walkTo(Player.DIRECTION_NONE);
		}
	}
	
	private function onMouseDown(e: MouseEvent) {
		if (e.type == MouseEvent.MOUSE_DOWN) {
			player.shoot(true);
		}
		
		if (e.type == MouseEvent.RIGHT_MOUSE_DOWN) {
			player.shootAlt(true);
		}
		
		trace(e.stageX, e.stageY, e.type);
	}
	
	private function onMouseUp(e: MouseEvent) {
		
	}
	
	public function addPlayer(player: Player) {
		this.player = player;
	}
	
}