import 'package:bloc/bloc.dart';
import 'package:bishop/bishop.dart' as bishop;
import 'package:squares/squares.dart';

class CreatorController extends Cubit<CreatorState> {
  CreatorController(bishop.Variant? variant) : super(CreatorState.initial()) {
    setBoard(variant);
  }

  void setBoard(bishop.Variant? variant, [int colour = 0]) {
    if (variant == null) {
      emit(CreatorState.initial());
    } else {
      bishop.Game game = bishop.Game(variant: variant);
      BoardState boardState = BoardState(
        board: game.boardSymbols(),
        orientation: colour,
      );
      emit(CreatorState(
        boardState: boardState,
        size: BoardSize(game.size.h, game.size.v),
      ));
      Future.delayed(Duration(seconds: 2)).then((_) => setBoard(variant, 1 - colour));
    }
  }
}

class CreatorState {
  final BoardState boardState;
  final BoardSize size;

  CreatorState({
    required this.boardState,
    this.size = const BoardSize(6, 6),
  });
  factory CreatorState.initial() => CreatorState(boardState: BoardState.empty());
}
