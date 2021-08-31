import 'package:bishop/bishop.dart' as bishop;
import 'package:hive/hive.dart';

part 'game_settings.g.dart';

@HiveType(typeId: 1)
class GameSettings {
  @HiveField(0)
  final int variant;
  @HiveField(1)
  final int gameTime;

  const GameSettings({required this.variant, required this.gameTime});
  factory GameSettings.standard() => GameSettings(variant: Variants.MINI_RANDOM, gameTime: 60);

  GameSettings copyWith({
    int? variant,
    int? gameTime,
  }) =>
      GameSettings(
        variant: variant ?? this.variant,
        gameTime: gameTime ?? this.gameTime,
      );
}

class Variants {
  static const int DEFAULT = MINI_RANDOM;
  static const int MINI_RANDOM = 0;
  static const int MINI = 1;
  static const int MICRO = 2;

  static Map<int, bishop.Variant> variants = {
    Variants.MINI_RANDOM: bishop.Variant.miniRandom(),
    Variants.MINI: bishop.Variant.mini(),
    Variants.MICRO: bishop.Variant.micro(),
  };

  static bishop.Variant get defaultVariant => variants[DEFAULT]!;
}
