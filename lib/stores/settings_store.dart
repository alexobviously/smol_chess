import 'package:hive/hive.dart';
import 'package:smol_chess/extensions/ready_mixin.dart';
import 'package:smol_chess/model/constants.dart';
import 'package:smol_chess/model/game_settings.dart';

class SettingsStore {
  late final Box box;

  SettingsStore._() {
    box = Hive.box(BOX_SETTINGS);
  }
  static SettingsStore _instance = SettingsStore._();
  factory SettingsStore() => _instance;

  GameSettings get gameSettings {
    GameSettings? gs = box.get(KEY_GAME_SETTINGS);
    if (gs == null) {
      gs = GameSettings.standard();
      box.put(KEY_GAME_SETTINGS, gs);
    }
    return gs;
  }

  set gameSettings(GameSettings gs) {
    box.put(KEY_GAME_SETTINGS, gs);
  }
}
