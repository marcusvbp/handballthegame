import 'dart:async';

import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class PostBack extends SpriteComponent with HasGameRef<HandeballTheGame> {
  final PostBackSide side;
  PostBack({super.priority, super.position, this.side = PostBackSide.left});

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('post_back.png'));
    if (side == PostBackSide.right) {
      flipHorizontally();
    }
    return super.onLoad();
  }
}

enum PostBackSide { left, right }
