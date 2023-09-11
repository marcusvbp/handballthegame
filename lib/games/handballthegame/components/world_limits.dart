import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class WorldLimits extends RectangleComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  WorldLimits()
      : super(
          size: Vector2(2626, 1091) * 1.3,
        );

  final List<Vector2> hitboxLimits = [
    Vector2(750, 0), // linha superior
    Vector2(2650, 0), // linha direita
    Vector2(3413, 1313), // linha inferior
    Vector2(0, 1313), // linha esquerda
  ];

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    center = Vector2(0, 0);
    paint = Paint()..color = const Color.fromARGB(255, 111, 70, 17);
    add(
      PolygonHitbox(
        hitboxLimits,
      ),
    );
    return super.onLoad();
  }
}
