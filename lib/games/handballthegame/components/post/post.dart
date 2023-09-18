import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/components/post/post_front.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class Post extends PositionComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  final PostSide side;
  Post({super.priority, super.position, this.side = PostSide.left}) : super();

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    add(PostFront());
    if (side == PostSide.right) {
      flipHorizontally();
    }

    add(PolygonHitbox([
      Vector2(200, 30),
      Vector2(210, 30),
      Vector2(210, 240),
      Vector2(110, 428),
      Vector2(100, 428),
      Vector2(200, 240),
    ]));

    return super.onLoad();
  }
}

enum PostSide { left, right }
