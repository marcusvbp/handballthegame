import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 20,
    paint: BasicPalette.gray.withAlpha(200).paint(),
  ),
  background: CircleComponent(
    radius: 60,
    paint: BasicPalette.white.withAlpha(100).paint(),
  ),
  margin: const EdgeInsets.only(left: 1, bottom: 10),
);
