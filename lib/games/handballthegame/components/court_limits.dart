import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class CourtLimits extends RectangleComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  CourtLimits({super.position}) : super(size: Vector2(2826, 1291));

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    add(RectangleHitbox());
    return super.onLoad();
  }
}
