import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:handballthegame/games/handballthegame/components/player.dart';
import 'package:handballthegame/games/handballthegame/inputs/joystick.dart';
import 'package:handballthegame/games/handballthegame/players/boy.dart';
import 'package:handballthegame/games/handballthegame/scenarios/court.dart';

class HandeballTheGame extends FlameGame
    with DragCallbacks, HasCollisionDetection {
  HandeballTheGame();
  late HandballCourt court;
  late Player _player;

  final world = World();
  late final CameraComponent cameraComponent;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAll([
      'court.png',
      'post.png',
      'boy_idle.png',
      'boy_run.png',
      'shadow.png',
    ]);
    court = HandballCourt();
    cameraComponent = CameraComponent(
      world: world,
    );
    cameraComponent.viewfinder.anchor = Anchor.center;

    cameraComponent.setBounds(
        Rectangle.fromCenter(center: court.center, size: Vector2(2000, 1000)));

    _player = Player(
      joystick: joystick,
      position: court.center + Vector2(-70, -170),
      character: BoyPlayer(),
    );

    world.add(court);
    world.add(_player);

    addAll([cameraComponent, world, joystick]);

    cameraComponent.follow(_player);

    return super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   cameraComponent.viewfinder.position = _getCameraPosition();
  //   super.update(dt);
  // }

  // Vector2 _getCameraPosition() {
  //   double y = _player.position.y;
  //   double x = _player.position.x;
  //   if (_player.position.y <= -201) {
  //     y = -201;
  //   } else if (_player.position.y >= 138) {
  //     y = 138;
  //   } else {
  //     y = _player.position.y;
  //   }

  //   if (_player.position.x <= -930) {
  //     x = -930;
  //   } else if (_player.position.x >= 930) {
  //     x = 930;
  //   } else {
  //     x = _player.position.x;
  //   }

  //   return Vector2(x, y);
  // }
}
