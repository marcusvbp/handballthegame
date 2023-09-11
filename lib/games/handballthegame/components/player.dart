import 'dart:async';
import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/components/shadow.dart';
import 'package:handballthegame/games/handballthegame/components/world_limits.dart';
import 'package:handballthegame/games/handballthegame/game.dart';
import 'package:handballthegame/games/handballthegame/players/character.dart';
import 'package:handballthegame/games/handballthegame/scenarios/court.dart';

class Player extends PositionComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  final Character character;
  final JoystickComponent? joystick;
  Player({required super.position, required this.character, this.joystick})
      : super();

  JoystickDirection lastDirection = JoystickDirection.right;
  final double _speed = 10;
  bool isOutOfLimits = false;

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
  final List<JoystickDirection> _topDirections = [
    JoystickDirection.up,
    JoystickDirection.upLeft,
    JoystickDirection.upRight,
  ];
  final List<JoystickDirection> _bottomDirections = [
    JoystickDirection.down,
    JoystickDirection.downLeft,
    JoystickDirection.downRight,
  ];

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    final shadow = Shadow(
      position: Vector2(25, 50),
      size: Vector2(49, 21),
    );

    add(shadow);
    add(character as Component);
    add(RectangleHitbox(
      size: Vector2(65, 115),
      position: Vector2(0, -62),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    move();
    updateSpriteOnMove();
    flipSpriteOnDirectionChange();
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
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is WorldLimits) {
      // if (intersectionPoints.length == 2) {
      //   final mid = (intersectionPoints.elementAt(0) +
      //           intersectionPoints.elementAt(1)) /
      //       2;

      //   final collisionVector = absoluteCenter - mid;
      //   double penetrationDepth = (size.x / 2) - collisionVector.length;

      //   collisionVector.normalize();
      //   position += collisionVector.scaled(penetrationDepth);
      // }
      log('atingiu o limite do mundo');
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void move() {
    if (joystick != null) {
      position.add(joystick!.relativeDelta * _speed);
    }
  }

  void updateSpriteOnMove() {
    if (joystick != null) {
      if (joystick!.direction == JoystickDirection.idle) {
        character.animationIdle();
      }
      if (joystick!.direction != JoystickDirection.idle) {
        character.animationRun();
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
