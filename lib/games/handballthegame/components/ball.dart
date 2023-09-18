import 'dart:async';

import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/components/ball_body.dart';
import 'package:handballthegame/games/handballthegame/components/shadow_body.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class Ball extends PositionComponent with HasGameRef<HandeballTheGame> {
  Ball({super.position});

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    anchor = Anchor.center;

    add(ShadowBody(position: Vector2(0, 30), size: Vector2(25, 10)));
    add(BallBody(position: Vector2(0, -30)));
    return super.onLoad();
  }
}
