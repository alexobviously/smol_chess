import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bishop/bishop.dart' as bishop;
import 'package:smol_chess/model/game_settings.dart';
import 'package:squares/squares.dart';

class CreatorController extends Cubit<CreatorState> {
  CreatorController(this.settings) : super(CreatorState.initial()) {
    setVariant(settings.variant);
    _resetTimer();
  }

  BoardState boardState = BoardState.empty();
  BoardSize size = BoardSize(6, 6);
  GameSettings settings;
  bishop.Variant get variant => Variants.variants[settings.variant] ?? Variants.defaultVariant;
  Timer? timer;

  void emitState() {
    emit(CreatorState(
      boardState: boardState,
      size: size,
      settings: settings,
    ));
  }

  void _resetTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 2), (_) => _timerTick());
    print(timer!.isActive);
  }

  void _timerTick() {
    setBoard(variant, 1 - state.boardState.orientation);
  }

  void setBoard(bishop.Variant? variant, [int colour = 0]) {
    if (variant == null) {
      emit(CreatorState.initial());
    } else {
      bishop.Game game = bishop.Game(variant: variant);
      boardState = BoardState(
        board: game.boardSymbols(),
        orientation: colour,
      );
      emitState();
      //Future.delayed(Duration(seconds: 2)).then((_) => setBoard(variant, 1 - colour));
    }
  }

  void setVariant(int v) {
    settings = settings.copyWith(variant: v);
    size = BoardSize(variant.boardSize.h, variant.boardSize.v);
    setBoard(variant, state.boardState.orientation);
    _resetTimer();
  }

  void setGameTime(int g) {
    settings = settings.copyWith(gameTime: g);
    emitState();
  }
}

class CreatorState {
  final BoardState boardState;
  final BoardSize size;
  final GameSettings settings;

  CreatorState({
    required this.boardState,
    this.size = const BoardSize(6, 6),
    required this.settings,
  });
  factory CreatorState.initial() => CreatorState(
        boardState: BoardState.empty(),
        settings: GameSettings.standard(),
      );
}
