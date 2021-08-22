import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smol_chess/game/game_manager.dart';
import 'package:smol_chess/ui/game_board.dart';
import 'package:smol_chess/ui/new_board.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

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
                      return Scrollbar(
                        thickness: 4,
                        child: ScrollablePositionedList.separated(
                          itemScrollController: itemScrollController,
                          itemPositionsListener: itemPositionsListener,
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<GameManager, GameManagerState>(
        builder: (context, state) {
          if (state.numReady > 0 && state.games.length > 1) {
            return FloatingActionButton(
              child: Text(
                '${state.numReady}',
                style: textTheme.headline5!.copyWith(fontFamily: GoogleFonts.abel().fontFamily),
              ),
              onPressed: () {
                itemScrollController.scrollTo(index: state.importantGame, duration: Duration(milliseconds: 250));
              },
            );
          } else
            return Container();
        },
      ),
    );
  }
}
