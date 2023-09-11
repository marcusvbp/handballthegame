import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

import 'character.dart';

class BoyPlayer extends SpriteAnimationComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks, Character {
  // final JoystickComponent? joystick;

  BoyPlayer({
    super.position,
  }) : super(size: Vector2.all(125), anchor: Anchor.centerLeft);

  late SpriteAnimation _animationIdle;
  late SpriteAnimation _animationRun;

  @override
  FutureOr<void> onLoad() async {
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

    return super.onLoad();
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
