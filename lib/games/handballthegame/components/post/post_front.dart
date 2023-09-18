import 'dart:async';

import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class PostFront extends SpriteComponent with HasGameRef<HandeballTheGame> {
  PostFront({super.priority, super.position});

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('post_front.png'));
    return super.onLoad();
  }
}
