import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:handballthegame/games/handballthegame/inputs/joystick.dart';
import 'package:handballthegame/games/handballthegame/players/boy.dart';
import 'package:handballthegame/games/handballthegame/scenarios/court.dart';

class HandeballTheGame extends FlameGame with DragCallbacks {
  HandeballTheGame();
  late HandballCourt court;
  late BoyPlayer _boyPlayer;

  final world = World();
  late final CameraComponent cameraComponent;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAll([
      'court.png',
      'post.png',
      'boy_idle.png',
      'boy_run.png',
    ]);
    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.center;
    addAll([cameraComponent, world]);

    court = HandballCourt();
    _boyPlayer = BoyPlayer(
      joystick: joystick,
      position: Vector2(court.center.x - 70, court.center.y - 170),
    );

    world.add(court);
    world.add(_boyPlayer);

    add(joystick);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    cameraComponent.viewfinder.position = _boyPlayer.position;
    super.update(dt);
  }
}
