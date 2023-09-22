import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class BallBody extends BodyComponent<HandeballTheGame> {
  final Vector2? initialPosition;

  BallBody({this.initialPosition});

  @override
  Body createBody() {
    final body = BodyDef(
      type: BodyType.dynamic,
      position: initialPosition,
    );
    final shape = CircleShape();
    shape.radius = 10;
    final fixture = FixtureDef(shape, restitution: .5);

    return world.createBody(body)..createFixture(fixture);
  }
}
