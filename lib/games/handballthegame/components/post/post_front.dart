import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class PostFront extends SpriteComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  PostFront({super.priority, super.position});

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    sprite = Sprite(game.images.fromCache('post_front.png'));
    add(PolygonHitbox([
      Vector2(118, 405),
      Vector2(119, 421),
      Vector2(109, 428),
      Vector2(10, 428),
      Vector2(0, 420),
      Vector2(120, 217),
      Vector2(223, 217),
      Vector2(223, 233),
      Vector2(216, 240),
      Vector2(134, 240),
      Vector2(33, 404),
      Vector2(118, 405),
    ]));
    return super.onLoad();
  }
}
