import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

void main() {
  runApp(const GameWidget.controlled(gameFactory: HandeballTheGame.new));
}
