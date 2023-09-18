import 'dart:async';
import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/components/arena.dart';
import 'package:handballthegame/games/handballthegame/components/shadow.dart';
import 'package:handballthegame/games/handballthegame/game.dart';
import 'package:handballthegame/games/handballthegame/players/character.dart';
import 'package:handballthegame/games/handballthegame/scenarios/court.dart';

class Player extends PositionComponent
    with HasGameRef<HandeballTheGame>, CollisionCallbacks {
  final Character character;
  final JoystickComponent? joystick;

  Player({
    required super.position,
    required this.character,
    this.joystick,
    super.priority,
  }) : super();

  JoystickDirection lastDirection = JoystickDirection.right;
  JoystickDirection? _collisionDirection;
  bool _hasCollidedWorldLimit = false;
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
      collisionType: CollisionType.active,
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Arena) {
      _hasCollidedWorldLimit = true;
      if (_topDirections.contains(joystick?.direction)) {
        _collisionDirection = JoystickDirection.up;
      } else if (_rightDirections.contains(joystick?.direction)) {
        _collisionDirection = JoystickDirection.right;
      } else if (_bottomDirections.contains(joystick?.direction)) {
        _collisionDirection = JoystickDirection.down;
      } else {
        _collisionDirection = JoystickDirection.left;
      }

      log('atingiu o limite do mundo');
    }
    super.onCollision(intersectionPoints, other);
  }

  void move() {
    if (joystick != null) {
      position.add(joystick!.relativeDelta * _speed);
      // if (!_hasCollidedWorldLimit) {
      // } else {
      //   joystick!.
      //   if(_collisionDirection != )
      // }
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
