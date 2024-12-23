import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flappy_dash_game/component/dash.dart';
import 'package:flappy_dash_game/component/dash_parallax_background.dart';
import 'package:flappy_dash_game/component/pipe_pair.dart';
import 'package:flappy_dash_game/flappy_dash_game.dart';

class FlappyDashRootComponent extends Component
    with HasGameRef<FlappyDashGame>, FlameBlocReader<GameCubit, GameState> {
  late Dash _dash;
  late PipePair _lastPipe;
  static const _pipesDistance = 400.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(DashParallaxBackground());
    add(_dash = Dash());
    _generatePipes(fromX: 350);

    // game.camera.viewfinder.add(
    //   _scoreText = TextComponent(
    //     position: Vector2(0, -(game.size.y / 2)),
    //   ),
    // );
  }

  void _generatePipes({
    int count = 20,
    double fromX = 0.0,
  }) {
    for (var i = 0; i < count; i++) {
      const area = 600;
      final y = (Random().nextDouble() * area) - (area / 2);
      add(_lastPipe =
          PipePair(position: Vector2(fromX + i * _pipesDistance, y)));
      // add(PipePair(position: Vector2(fromX + i * distance, y)));
    }
  }

  void onSpaceDown() {
    _checkToStart();
    _dash.jump();
  }

  void onTapDown(TapDownEvent event) {
    _checkToStart();
    _dash.jump();
  }

  void _removeLastPipes() {
    final pipes = children.whereType<PipePair>();
    final shouldBeRemoved = max(pipes.length - 5, 0);
    pipes.take(shouldBeRemoved).forEach((pipe) {
      pipe.removeFromParent();
    });
  }

  void _checkToStart() {
    if (bloc.state.currentPlayingState.isNone) {
      bloc.startPlaying();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // _scoreText.text = bloc.state.currentScore.toString();
    if (_dash.x >= _lastPipe.x) {
      _generatePipes(fromX: _pipesDistance);
      _removeLastPipes();
    }
  }
}
