
import phaser.gameobjects.Text;
import phaser.gameobjects.Group;
import phaser.tilemaps.ObjectLayer;

import phaser.tilemaps.TilemapLayer;
import phaser.tilemaps.Tilemap;


// You can make your game here, or create other .hx files.
class PlayScene extends Scene {
	var player:Player;
	var world:Tilemap;
	var solid:TilemapLayer;
	
	var objectData:ObjectLayer;
	var coinGroup:Group;
	var scoreCount:Int=1;
	var scoreText:Text;

	public function preload() {
		this.load.image("sheet", "assets/grassSET.png");
		this.load.spritesheet("CoinSprite", "assets/HaxeParticle.png", { frameWidth: 16, frameHeight: 16});
		this.load.spritesheet("player", "assets/player.png", {frameWidth: 20, frameHeight: 24});
		this.load.tilemapTiledJSON("tileMap", "assets/World.json");
	}

	public function create() {
		// init player sprite will automatically be add as we decleard the "player" id in the Player class Constructor
		// and will be added to the scene
		/// player=this.physics.add();
		player = new Player(this, 100, 200);
		
		//coin group
		coinGroup = this.physics.add.group();
		
		// init tilemap
		world = this.make.tilemap({key: "tileMap"});
	
		//  coinGroup.get(100,100,'coinSprite');

		final tileSet = world.addTilesetImage("grassSET", "sheet");
		// solid is the name of the tilemap layer name which you name in the Tiled editor
		solid = world.createLayer('solid', tileSet);
		

		// camera to follow player
		this.cameras.main.startFollow(this.player);
		this.cameras.main.setZoom(1);
		///   this.cameras.main.setBackgroundColor(0x14B3BE);
		this.cameras.main.setBounds(0, 0, world.widthInPixels, world.heightInPixels);

		// set the tiles we want the player to collide with
		this.solid.setCollisionByProperty({collides:true});

		// and activating collisions between the player , tilemap ,and coins...
		this.physics.add.collider(this.solid, this.player, () -> {});
		this.physics.add.collider(this.solid, this.coinGroup, () -> {});
		// parameters are needed for this to work
		this.physics.add.overlap(this.player, coinGroup, (player, coins) -> delCoin(player, coins));

		
		scoreText = this.add.text(50, 50, "Score : 0" );
		scoreText.setScrollFactor(0, 0);
		// this.add.text(100,100,"Score : "+scoreCount,{fontSize: 13});
		spawnEntites();
	}

	public function delCoin(player, coins:Coins) {
		scoreText.setText("Score : " + scoreCount++);
		coins.destroy(true);
	}

	public function spawnEntites() {
		objectData = world.getObjectLayer("obj");
		
		for (jects in objectData.objects) {
			if (jects.name == "playerSpawn") {
				player.setPosition(jects.x, jects.y);
			} else if (jects.name == "coin") {
				coinGroup.add(new Coins(this,jects.x, jects.y));
			}
		}
	}

	override public function update(time:Float, delta:Float) {
		//keep the player update 
		player.update(time);

		super.update(time, delta);

		
		if (this.input.keyboard.addKey("R").isDown) {
			this.scene.restart();
		}

     
	}
}
