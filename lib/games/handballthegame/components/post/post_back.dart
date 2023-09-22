import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class PostBack extends SpriteComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  final PostBackSide side;
  PostBack({super.priority, super.position, this.side = PostBackSide.left});

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    sprite = Sprite(game.images.fromCache('post_back.png'));
    if (side == PostBackSide.right) {
      flipHorizontally();
    }

    add(PolygonHitbox([
      Vector2(200, 30),
      Vector2(210, 30),
      Vector2(210, 240),
      Vector2(110, 413),
      Vector2(100, 413),
      Vector2(200, 240),
    ]));

    return super.onLoad();
  }
}

enum PostBackSide { left, right }
