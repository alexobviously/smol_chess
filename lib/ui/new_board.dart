import 'package:bishop/bishop.dart' as bishop;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smol_chess/game/create_controller.dart';
import 'package:squares/squares.dart';

class NewBoard extends StatelessWidget {
  final Function(bishop.Variant) onCreate;
  const NewBoard({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    CreatorController controller = CreatorController(bishop.Variant.miniRandom());
    return Stack(
      alignment: Alignment.center,
      children: [
        BlocBuilder<CreatorController, CreatorState>(
          bloc: controller,
          builder: (context, state) {
            return Board(
              boardKey: GlobalKey(),
              pieceSet: PieceSet.merida(),
              theme: BoardTheme.BROWN,
              state: state.boardState,
              size: state.size,
            );
          },
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(shape: CircleBorder(), padding: EdgeInsets.all(10)),
            onPressed: () => onCreate(bishop.Variant.miniRandom()),
            child: Icon(Icons.add, size: 50),
          ),
        ),
      ],
    );
  }
}
