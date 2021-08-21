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
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    GameManager gm = BlocProvider.of<GameManager>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  'smol chess',
                  style: textTheme.headline2,
                ),
                Expanded(
                  child: BlocBuilder<GameManager, GameManagerState>(
                    builder: (context, state) {
                      return ListView.separated(
                        itemCount: state.games.length + 1,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: EdgeInsets.all(16),
                            child: i < state.games.length
                                ? GameBoard(
                                    controller: state.games[i],
                                  )
                                : NewBoard(
                                    onCreate: (v) => gm.createGame(v),
                                  ),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return Container(height: 1, color: Colors.grey);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
