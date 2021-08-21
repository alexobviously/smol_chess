import 'package:bishop/bishop.dart' as bishop;
import 'package:bloc/bloc.dart';
import 'package:smol_chess/model/game_settings.dart';
import 'package:smol_chess/stores/settings_store.dart';
import 'package:squares/squares.dart';

import 'package:smol_chess/game/game_controller.dart';

class GameManager extends Cubit<GameManagerState> {
  GameManager() : super(GameManagerState.initial());

  List<GameController> games = [];

  void emitState() {
    emit(GameManagerState(games: games));
  }

  void createGame(GameSettings settings) {
    SettingsStore().gameSettings = settings;
    bishop.Variant variant = Variants.variants[settings.variant] ?? Variants.defaultVariant;
    print('GM createGame(${variant.name})');
    GameController gc = GameController(manager: this);
    gc.startGame(variant);
    games.add(gc);
    emitState();
  }

  void submitMove(GameController gc, Move move) async {
    if (gc.gameOver) {
      endGame(gc);
    } else {
      await Future.delayed(Duration(milliseconds: 250));
      gc.randomMove();
    }
  }

  void endGame(GameController gc) {
    games.remove(gc);
    emitState();
  }
}

class GameManagerState {
  final List<GameController> games;

  GameManagerState({required this.games});
  factory GameManagerState.initial() => GameManagerState(games: []);
}
