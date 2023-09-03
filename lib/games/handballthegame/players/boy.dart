import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class BoyPlayer extends SpriteAnimationComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  final JoystickComponent? joystick;

  BoyPlayer({
    required super.position,
    this.joystick,
  }) : super(size: Vector2.all(125), anchor: Anchor.centerLeft);

  late SpriteAnimation animationIdle;
  late SpriteAnimation animationRun;
  JoystickDirection lastDirection = JoystickDirection.right;
  final double _speed = 10;
  // late double _bottomBound;
  // late double _topBound;

  final List<JoystickDirection> _rightDirections = [
    JoystickDirection.right,
    JoystickDirection.upRight,
    JoystickDirection.downRight,
  ];
  final List<JoystickDirection> _leftDirections = [
    JoystickDirection.left,
    JoystickDirection.upLeft,
    JoystickDirection.downLeft,
  ];
  // final List<JoystickDirection> _topDirections = [
  //   JoystickDirection.upLeft,
  //   JoystickDirection.upRight,
  //   JoystickDirection.up,
  // ];
  // final List<JoystickDirection> _downDirections = [
  //   JoystickDirection.downLeft,
  //   JoystickDirection.downRight,
  //   JoystickDirection.down,
  // ];

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;

    animationIdle = SpriteAnimation.fromFrameData(
      game.images.fromCache('boy_idle.png'),
      SpriteAnimationData.sequenced(
        amount: 15,
        stepTime: 0.05,
        textureSize: Vector2(218, 200),
      ),
    );

    animationRun = SpriteAnimation.fromFrameData(
      game.images.fromCache('boy_run.png'),
      SpriteAnimationData.sequenced(
        amount: 15,
        stepTime: 0.05,
        textureSize: Vector2(218, 200),
      ),
    );

    animation = animationIdle;

    // _bottomBound = gameRef.court.height / 2 - 175;
    // _topBound = (_bottomBound + 225) * -1;

    add(RectangleHitbox(size: Vector2(65, 115)));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    move();
    // if (joystick != null) {
    //   if (y >= _topBound && _topDirections.contains(joystick!.direction)) {
    //     move();
    //   }
    //   if (y <= _bottomBound && _downDirections.contains(joystick!.direction)) {
    //     move();
    //   }
    //   if (joystick!.direction == JoystickDirection.left ||
    //       joystick!.direction == JoystickDirection.right) {
    //     move();
    //   }
    // }
    updateSpriteOnMove();
    flipSpriteOnDirectionChange();
  }

  void move() {
    if (joystick != null) {
      position.add(joystick!.relativeDelta * _speed);
    }
  }

  void updateSpriteOnMove() {
    if (joystick != null) {
      if (joystick!.direction == JoystickDirection.idle) {
        animation = animationIdle;
      }
      if (joystick!.direction != JoystickDirection.idle) {
        animation = animationRun;
      }
    }
  }

  void flipSpriteOnDirectionChange() {
    if (joystick != null) {
      if (_rightDirections.contains(joystick!.direction)) {
        lastDirection = JoystickDirection.right;
      } else if (_leftDirections.contains(joystick!.direction)) {
        lastDirection = JoystickDirection.left;
      }
      if (lastDirection == JoystickDirection.left && scale.x > 0) {
        flipHorizontally();
      } else if (lastDirection == JoystickDirection.right && scale.x < 0) {
        flipHorizontally();
      }
    }
  }
}
