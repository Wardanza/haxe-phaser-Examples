package;

import js.html.Console;
import phaser.tilemaps.TilemapLayer;
import phaser.physics.arcade.Tilemap;
import phaser.physics.arcade.components.Velocity;
import phaser.types.input.keyboard.CursorKeys;
import phaser.input.keyboard.Key;
import phaser.physics.arcade.Body;
import phaser.physics.Arcade;
import phaser.textures.Texture;
import phaser.physics.arcade.Image;
import phaser.physics.arcade.Sprite;
import phaser.gameobjects.Rectangle;

class Player extends Sprite {
	// for custom keyboard input
	var keys:Map<String, Key>;
	var player:Image;
	var isGrounded:Bool;

	public function new(scene:Scene, x:Float, y:Float) {
		super(scene, x, y, "player");

		this.scene.add.existing(this);
		
		this.scene.physics.add.existing(this);

		this.setFlipX(true);
		this.setBounce(0.5);

		this.anims.create({
			key: "idle",
			frames: this.anims.generateFrameNames("player", {frames: [0]}),
			frameRate: 5,
		});
		this.anims.create({
			key: "walk",
			frames: this.anims.generateFrameNames("player", {frames: [1]}),
			frameRate: 5,
			repeat: -1,
		});

		// assign custom keys
		keys = [
			"up" => scene.input.keyboard.addKey("W"),
			"left" => scene.input.keyboard.addKey("A"),
			"right" => scene.input.keyboard.addKey("D"),
		];

	}


	override public function update(dt:Dynamic) {
		super.update(Dynamic);
		if (keys["left"].isDown) {
			setVelocityX(-100);
			flipX = false;
			this.anims.play("walk");
		} else if (keys["right"].isDown) {
			setVelocityX(100);
			flipX = true;
			this.anims.play("walk");
		} else {
			setVelocityX(0);
			this.anims.play("idle");
		}
		//this gave quite the problem dont use touching use this instead
		if (keys["up"].isDown && this.body.asType1.blocked.down) {
			setVelocityY(-200);
		}

	
	}
}
