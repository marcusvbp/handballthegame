import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class HandballCourt extends SpriteComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  HandballCourt() : super(size: Vector2(2626, 1091), anchor: Anchor.center);

  List<Vector2> hitboxLimits = [
    Vector2(900, 0), // linha superior
    Vector2(2393, 0), // linha direita
    Vector2(2626, 956), // linha inferior
    Vector2(0, 1200), // linha esquerda
  ];

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    sprite = Sprite(game.images.fromCache('court.png'));
    add(
      PolygonHitbox(hitboxLimits),
    );
    return super.onLoad();
  }
}
