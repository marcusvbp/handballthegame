import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class BallBody extends BodyComponent<HandeballTheGame> {
  final Vector2? initialPosition;
  final Vector2? gravityOverride;

  BallBody({this.initialPosition, this.gravityOverride});

  @override
  Body createBody() {
    final body = BodyDef(
      type: BodyType.dynamic,
      position: initialPosition,
      gravityOverride: gravityOverride,
    );
    final shape = CircleShape();
    shape.radius = 10;
    final fixture = FixtureDef(shape, restitution: .5);

    return world.createBody(body)..createFixture(fixture);
  }
}
