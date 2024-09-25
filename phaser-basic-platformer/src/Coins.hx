package;

import phaser.display.Bounds;
import phaser.physics.arcade.Sprite;


class Coins extends Sprite {
    public function new(scene:Scene,x:Float,y:Float){
        super(scene,x,y,"CoinSprite");
        //adds a sprite to the scene
         this.scene.add.existing(this);
         //adds physics to the sprite
         this.scene.physics.add.existing(this);
    }

    override public function update(dt:Dynamic){
        
    }
}