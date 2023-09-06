import 'dart:async';
import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';
import 'package:handballthegame/games/handballthegame/scenarios/court.dart';

import 'character.dart';

class BoyPlayer extends SpriteAnimationComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks, Character {
  // final JoystickComponent? joystick;

  BoyPlayer({
    super.position,
  }) : super(size: Vector2.all(125), anchor: Anchor.centerLeft);

  bool isOutOfLimits = false;
  late SpriteAnimation _animationIdle;
  late SpriteAnimation _animationRun;

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;

    _animationIdle = SpriteAnimation.fromFrameData(
      game.images.fromCache('boy_idle.png'),
      SpriteAnimationData.sequenced(
        amount: 15,
        stepTime: 0.05,
        textureSize: Vector2(218, 200),
      ),
    );

    _animationRun = SpriteAnimation.fromFrameData(
      game.images.fromCache('boy_run.png'),
      SpriteAnimationData.sequenced(
        amount: 15,
        stepTime: 0.05,
        textureSize: Vector2(218, 200),
      ),
    );

    animation = _animationIdle;

    add(RectangleHitbox(
      size: Vector2(65, 115),
    ));

    return super.onLoad();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is HandballCourt) {
      if (!isOutOfLimits) {
        isOutOfLimits = true;
        log('O Jogador saiu do campo');
      }
    }
    super.onCollisionEnd(other);
  }

  @override
  void animationIdle() {
    animation = _animationIdle;
  }

  @override
  void animationRun() {
    animation = _animationRun;
  }
}
