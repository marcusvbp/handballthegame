import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class Arena extends RectangleComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  Arena({super.size, super.position}) : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    debugMode = true;

    paint = Paint()..color = const Color.fromARGB(255, 127, 68, 9);

    add(
      RectangleHitbox(
        size: size - Vector2(10, 10),
        position: Vector2(5, 5),
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }
}
