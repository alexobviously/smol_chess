import 'package:bishop/bishop.dart' as bishop;
import 'package:hive/hive.dart';

part 'game_settings.g.dart';

@HiveType(typeId: 1)
class GameSettings {
  @HiveField(0)
  final int variant;
  @HiveField(1)
  final int gameTime;

  GameSettings({required this.variant, required this.gameTime});
  factory GameSettings.standard() => GameSettings(variant: Variants.MINI_RANDOM, gameTime: 60);
}

class Variants {
  static const int MINI_RANDOM = 0;
  static const int MINI = 1;
  static const int MICRO = 2;
}
