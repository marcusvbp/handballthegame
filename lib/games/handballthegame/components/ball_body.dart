import 'package:flame/collisions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:handballthegame/games/handballthegame/game.dart';

class BallBody extends BodyComponent<HandeballTheGame> with CollisionCallbacks {
  final Vector2? position;

  BallBody({this.position});

  @override
  Body createBody() {
    final body = BodyDef(
      type: BodyType.dynamic,
      position: position,
    );
    final shape = CircleShape();
    shape.radius = 10;
    final fixture = FixtureDef(shape, restitution: .5);

    return world.createBody(body)..createFixture(fixture);
  }
}
