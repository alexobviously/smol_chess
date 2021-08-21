import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smol_chess/game/game_manager.dart';
import 'package:smol_chess/ui/game_board.dart';
import 'package:smol_chess/ui/new_board.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GameManager gm = BlocProvider.of<GameManager>(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: BlocBuilder<GameManager, GameManagerState>(
              builder: (context, state) {
                if (state.games.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: NewBoard(
                      onCreate: (v) => gm.createGame(v),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: GameBoard(
                      controller: state.games.first,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
