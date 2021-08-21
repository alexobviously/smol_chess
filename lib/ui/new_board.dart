import 'package:bishop/bishop.dart' as bishop;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smol_chess/game/create_controller.dart';
import 'package:smol_chess/model/game_settings.dart';
import 'package:smol_chess/stores/settings_store.dart';
import 'package:squares/squares.dart';

class NewBoard extends StatefulWidget {
  final Function(GameSettings) onCreate;
  const NewBoard({required this.onCreate});
  @override
  _NewBoardState createState() => _NewBoardState();
}

class _NewBoardState extends State<NewBoard> {
  CreatorController controller = CreatorController(bishop.Variant.miniRandom(), SettingsStore().gameSettings);

  void setVariant(int v) {
    controller.setVariant(v);
  }

  void setGameTime(int g) {
    controller.setGameTime(g);
  }

  List<IconData> variantIcons = [
    FontAwesomeIcons.diceThree,
    MdiIcons.sizeS,
    MdiIcons.sizeXs,
  ];

  List<IconData> timeIcons = [
    FontAwesomeIcons.meteor,
    FontAwesomeIcons.bolt,
    MdiIcons.turtle,
  ];

  List<int> gameTimes = [1, 3, 5];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatorController, CreatorState>(
      bloc: controller,
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Board(
              boardKey: GlobalKey(),
              pieceSet: PieceSet.merida(),
              theme: BoardTheme.BROWN,
              state: state.boardState,
              size: state.size,
            ),
            Align(
              alignment: Alignment.center,
              child: GlassmorphicContainer(
                width: 300,
                height: 250,
                borderRadius: 10,
                border: 1,
                blur: 10,
                linearGradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Color(0xFF00FFFF).withOpacity(0.05),
                ], stops: [
                  0.1,
                  1,
                ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.5),
                    Color((0xFFFFFFFF)).withOpacity(0.5),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('variant'),
                      ToggleButtons(
                        children: List.generate(variantIcons.length, (i) => Icon(variantIcons[i])).toList(),
                        isSelected: List<bool>.generate(variantIcons.length, (i) => i == state.settings.variant),
                        onPressed: (v) => setVariant(v),
                      ),
                      Text('time control'),
                      ToggleButtons(
                        children: List.generate(timeIcons.length, (i) => Icon(timeIcons[i])).toList(),
                        isSelected:
                            List<bool>.generate(timeIcons.length, (i) => gameTimes[i] == state.settings.gameTime),
                        onPressed: (v) => setGameTime(gameTimes[v]),
                      ),
                      Container(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: CircleBorder(), padding: EdgeInsets.all(10)),
                        onPressed: () => widget.onCreate(state.settings),
                        child: Text(
                          'play',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
