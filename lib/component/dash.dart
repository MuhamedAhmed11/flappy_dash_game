import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flappy_dash_game/component/hidden_coin.dart';
import 'package:flappy_dash_game/component/pipe.dart';
import 'package:flappy_dash_game/flappy_dash_game.dart';

class Dash extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef<FlappyDashGame>,
        FlameBlocReader<GameCubit, GameState> {
  Dash()
      : super(
          position: Vector2(0.0, 0.0),
          size: Vector2.all(80),
          anchor: Anchor.center,
          priority: 10,
        );

  late Sprite _dashSprite;
  final Vector2 _gravity = Vector2(0, 1400);
  Vector2 _velocity = Vector2(0, 0);
  final Vector2 _jumpForce = Vector2(0, -500);

  @override
  Future<void> onLoad() async {
    _dashSprite = await Sprite.load('dash.png');
    // debugMode = true;
    final radius = size.x / 2;
    final center = size / 2;
    add(
      CircleHitbox(
        radius: radius * .75,
        position: center * 1.1,
        anchor: Anchor.center,
      ),
    );
    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (bloc.state.currentPlayingState.isNotPlaying) {
      return;
    }
    _velocity += _gravity * dt;
    position += _velocity * dt;
  }

  void jump() {
    if (bloc.state.currentPlayingState.isNotPlaying) {
      return;
    }
    _velocity = _jumpForce;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(
      canvas,
      size: size,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (bloc.state.currentPlayingState.isNotPlaying) {
      return;
    }
    if (other is HiddenCoin) {
      // increment coins here
      bloc.increasScore();
      other.removeFromParent();
      // game.world.increaseScore(); // Before adding bloc
    } else if (other is Pipe) {
      // game over
      bloc.gameOver();
    }
  }
}
