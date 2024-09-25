// Define the game settings in here.

class Game {
    public static var phaser:phaser.Game;

    static public function start_game() {
        var physics = {
            arcade: {
                gravity: { y: 600 },
                debug: false,
            }
        };
        Reflect.setField(physics, 'default', 'arcade');
// We imported the scene into import.hx, but you can import it here or do: Game.play_scene = new PlayScene({key: "key"}) for example.
        var config = untyped {
            physics: physics,
            width: 500,
            height: 500,
            scene: [PlayScene]
        };
        Game.phaser = new phaser.Game(config);
    }
}

