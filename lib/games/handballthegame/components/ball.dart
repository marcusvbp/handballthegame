import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/components/ball_body.dart';
import 'package:handballthegame/games/handballthegame/components/player.dart';
import 'package:handballthegame/games/handballthegame/components/shadow_body.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class Ball extends PositionComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  Ball({super.position});
  late BallBody _ballBody;
  late CircleHitbox _hitbox;

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    _ballBody = BallBody(initialPosition: Vector2(0, -30));
    _hitbox = CircleHitbox(radius: 10, anchor: Anchor.center);
    anchor = Anchor.center;
    add(_hitbox);

    add(ShadowBody(initialPostition: Vector2(0, 30), size: Vector2(25, 10)));
    add(_ballBody);

    return super.onLoad();
  }

  @override
  Future update(double dt) async {
    super.update(dt);
    if (_ballBody.isMounted) {
      _hitbox.position = _ballBody.position;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
