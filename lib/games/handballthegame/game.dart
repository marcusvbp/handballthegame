import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide World;
import 'package:handballthegame/games/handballthegame/components/ball.dart';
import 'package:handballthegame/games/handballthegame/components/player.dart';
import 'package:handballthegame/games/handballthegame/components/post/post.dart';
import 'package:handballthegame/games/handballthegame/components/post/post_back.dart';
import 'package:handballthegame/games/handballthegame/inputs/joystick.dart';
import 'package:handballthegame/games/handballthegame/players/boy.dart';
import 'package:handballthegame/games/handballthegame/scenarios/court.dart';

class HandeballTheGame extends Forge2DGame
    with DragCallbacks, HasCollisionDetection {
  HandeballTheGame() : super(zoom: 1, gravity: Vector2(0, 150));
  late HandballCourt court;
  late Player _player;
  late Ball ball;
  late Post _post1;
  late Post _post2;
  late PostBack _postBack1;
  late PostBack _postBack2;

  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    final World world = World();

    await images.loadAll([
      'court.png',
      'post_back.png',
      'post_front.png',
      'boy_idle.png',
      'boy_run.png',
      'shadow.png',
    ]);
    final court = HandballCourt(priority: 0);
    cameraComponent = CameraComponent(
      world: world,
    );
    cameraComponent.viewfinder.anchor = Anchor.center;

    cameraComponent.setBounds(
        Rectangle.fromCenter(center: court.center, size: Vector2(2000, 1000)));

    _player = Player(
      joystick: joystick,
      position: court.center + Vector2(-70, -170),
      character: BoyPlayer(),
      priority: 1,
    );

    ball = Ball(
      position: court.center + Vector2(0, -200),
    );

    _postBack1 = PostBack(
      position: court.center - (court.size / 2) + Vector2(212, 20),
      priority: 0,
    );

    _postBack2 = PostBack(
      position: Vector2(court.size.x / 2 - 212, court.size.y / 2 * -1 + 17),
      priority: 0,
      side: PostBackSide.right,
    );

    _post1 = Post(
      position: court.center - (court.size / 2) + Vector2(203, 20),
      priority: 2,
    );

    _post2 = Post(
      position: Vector2(court.size.x / 2 - 203, court.size.y / 2 * -1 + 17),
      side: PostSide.right,
      priority: 2,
    );

    world.addAll([
      court,
      _player,
      ball,
      _post1,
      _postBack1,
      _post2,
      _postBack2,
    ]);

    addAll([cameraComponent, world, joystick]);

    cameraComponent.follow(_player);

    return super.onLoad();
  }
}
