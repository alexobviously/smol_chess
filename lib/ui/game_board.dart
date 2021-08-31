import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smol_chess/game/game_controller.dart';
import 'package:squares/squares.dart';

class GameBoard extends StatefulWidget {
  final GameController controller;
  GameBoard({required this.controller});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Move? premove;

  void onMove(Move move) {
    widget.controller.makeMove(move);
    premove = null;
  }

  void onPremove(Move move) {
    premove = move;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return BlocBuilder<GameController, GameState>(
      bloc: widget.controller,
      builder: (context, state) {
        return Column(
          children: [
            _playerInfo(context, 'Random-Mover'),
            Container(
              child: BoardController(
                pieceSet: PieceSet.merida(),
                size: state.size,
                state: state.board,
                theme: BoardTheme.BROWN,
                canMove: state.canMove,
                moves: state.moves,
                onMove: onMove,
                onPremove: onPremove,
              ),
            ),
            _playerInfo(context, 'Alex'),
          ],
        );
      },
    );
  }

  Widget _playerInfo(BuildContext context, String name) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Row(
      children: [
        Expanded(child: Text(name, style: textTheme.headline5)),
        Icon(FontAwesomeIcons.stopwatch),
        Container(width: 4),
        Text('5:00', style: textTheme.headline5),
      ],
    );
  }
}
