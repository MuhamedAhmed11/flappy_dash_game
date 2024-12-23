import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

  void startPlaying() {
    emit(state.copyWith(
      currentScore: 0,
      currentPlayingState: PlayingState.playing,
    ));
  }

  void increasScore() {
    emit(state.copyWith(
      currentScore: state.currentScore + 1,
    ));
  }

  void gameOver() {
    emit(state.copyWith(
      currentPlayingState: PlayingState.gameOver,
    ));
  }

  void restartGame() {
    emit(state.copyWith(
      currentScore: 0,
      currentPlayingState: PlayingState.none,
    ));
  }
}
