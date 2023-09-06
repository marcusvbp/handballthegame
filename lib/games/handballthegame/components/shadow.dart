import 'dart:async';

import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class Shadow extends SpriteComponent with HasGameRef<HandeballTheGame> {
  Shadow({super.position, super.priority, super.size});

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('shadow.png'));
    anchor = Anchor.center;
    return super.onLoad();
  }
}
