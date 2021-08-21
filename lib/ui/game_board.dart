import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smol_chess/game/game_controller.dart';
import 'package:squares/squares.dart';

class GameBoard extends StatefulWidget {
  final GameController controller;
  GameBoard({required this.controller});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameController, GameState>(
      bloc: widget.controller,
      builder: (context, state) {
        return Container(
          child: BoardController(
            pieceSet: PieceSet.merida(),
            size: state.size,
            state: state.board,
            theme: BoardTheme.BROWN,
            canMove: state.canMove,
            moves: state.moves,
          ),
        );
      },
    );
  }
}
