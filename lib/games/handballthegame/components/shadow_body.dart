import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:handballthegame/games/handballthegame/components/shadow.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class ShadowBody extends BodyComponent<HandeballTheGame> with ContactCallbacks {
  final Vector2? initialPostition;
  final Vector2? size;
  ShadowBody({this.initialPostition, this.size});

  @override
  Future<void> onLoad() {
    add(Shadow(size: size));
    return super.onLoad();
  }

  @override
  Body createBody() {
    final body = BodyDef(
      type: BodyType.static,
      position: initialPostition,
    );
    paint = Paint()..color = const Color(0x00000000);
    final shape = PolygonShape();
    shape.setAsBox(10, 2, Vector2(0, 3), 0);

    final fixture = FixtureDef(shape);

    return world.createBody(body)..createFixture(fixture);
  }
}
