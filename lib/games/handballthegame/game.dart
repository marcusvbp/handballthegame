import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:handballthegame/games/handballthegame/components/player.dart';
import 'package:handballthegame/games/handballthegame/components/world_limits.dart';
import 'package:handballthegame/games/handballthegame/inputs/joystick.dart';
import 'package:handballthegame/games/handballthegame/players/boy.dart';
import 'package:handballthegame/games/handballthegame/scenarios/court.dart';

class HandeballTheGame extends FlameGame
    with DragCallbacks, HasCollisionDetection {
  HandeballTheGame();
  late HandballCourt court;
  late Player _player;
  late final WorldLimits limits;

  final world = World();
  late final CameraComponent cameraComponent;

  @override
  FutureOr<void> onLoad() async {
    limits = WorldLimits();
    await images.loadAll([
      'court.png',
      'post.png',
      'boy_idle.png',
      'boy_run.png',
      'shadow.png',
    ]);
    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.center;
    addAll([cameraComponent, world]);

    court = HandballCourt();

    _player = Player(
      joystick: joystick,
      position: Vector2(court.center.x - 70, court.center.y - 170),
      character: BoyPlayer(),
    );
    world.add(limits);
    world.add(court);
    world.add(_player);

    add(joystick);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    cameraComponent.viewfinder.position = _getCameraPosition();
    super.update(dt);
  }

  Vector2 _getCameraPosition() {
    double y = _player.position.y;
    double x = _player.position.x;
    if (_player.position.y <= -201) {
      y = -201;
    } else if (_player.position.y >= 138) {
      y = 138;
    } else {
      y = _player.position.y;
    }

    if (_player.position.x <= -930) {
      x = -930;
    } else if (_player.position.x >= 930) {
      x = 930;
    } else {
      x = _player.position.x;
    }

    return Vector2(x, y);
  }
}
