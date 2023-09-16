import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide World;
import 'package:handballthegame/games/handballthegame/components/player.dart';
import 'package:handballthegame/games/handballthegame/inputs/joystick.dart';
import 'package:handballthegame/games/handballthegame/players/boy.dart';
import 'package:handballthegame/games/handballthegame/scenarios/court.dart';

class HandeballTheGame extends Forge2DGame
    with DragCallbacks, HasCollisionDetection {
  HandeballTheGame() : super(zoom: 1);
  late HandballCourt court;
  late Player _player;

  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    final World world = World();

    await images.loadAll([
      'court.png',
      'post.png',
      'boy_idle.png',
      'boy_run.png',
      'shadow.png',
    ]);
    final court = HandballCourt();
    cameraComponent = CameraComponent(
      world: world,
    );
    cameraComponent.viewfinder.anchor = Anchor.center;

    cameraComponent.setBounds(
        Rectangle.fromCenter(center: court.center, size: Vector2(2000, 1000)));

    // final arena = Arena(
    //   size: size,
    //   position: Vector2(0, 0),
    // );

    _player = Player(
      joystick: joystick,
      position: court.center + Vector2(-70, -170),
      character: BoyPlayer(),
    );

    world.addAll([
      // arena,
      court,
      _player,
    ]);

    addAll([cameraComponent, world, joystick]);

    cameraComponent.follow(_player);

    return super.onLoad();
  }
}
