import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/bloc/game/game_cubit.dart';
import 'package:flappy_dash_game/component/hidden_coin.dart';
import 'package:flappy_dash_game/component/pipe.dart';

class PipePair extends PositionComponent
    with FlameBlocReader<GameCubit, GameState> {
  PipePair({
    required super.position,
    this.gap = 200,
    this.speed = 100,
  });

  final double gap;
  final double speed;

  @override
  Future<void> onLoad() async {
    addAll([
      Pipe(
        isFlipped: false,
        position: Vector2(0, gap / 2),
      ),
      Pipe(
        isFlipped: true,
        position: Vector2(0, -gap / 2),
      ),
      HiddenCoin(position: Vector2(30, 0)),
    ]);
    await super.onLoad();
  }

  @override
  void update(double dt) {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.none:
        break;
      case PlayingState.playing:
        position.x -= speed * dt;
      case PlayingState.paused:
      case PlayingState.gameOver:
        break;
      default:
    }

    super.update(dt);
  }
}
