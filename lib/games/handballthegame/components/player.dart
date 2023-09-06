import 'dart:async';

import 'package:flame/components.dart';
import 'package:handballthegame/games/handballthegame/components/shadow.dart';
import 'package:handballthegame/games/handballthegame/players/character.dart';

class Player extends PositionComponent {
  final Character character;
  final JoystickComponent? joystick;
  Player({required super.position, required this.character, this.joystick})
      : super();

  JoystickDirection lastDirection = JoystickDirection.right;
  final double _speed = 10;

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

  @override
  FutureOr<void> onLoad() {
    final shadow = Shadow(
      position: Vector2(25, 50),
      size: Vector2(49, 21),
    );

    add(shadow);
    add(character as Component);
    return super.onLoad();
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

  @override
  void update(double dt) {
    super.update(dt);
    move();
    updateSpriteOnMove();
    flipSpriteOnDirectionChange();
  }
}
