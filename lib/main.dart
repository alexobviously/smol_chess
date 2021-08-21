import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smol_chess/game/game_manager.dart';
import 'package:smol_chess/model/constants.dart';
import 'package:smol_chess/model/game_settings.dart';
import 'package:smol_chess/ui/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GameSettingsAdapter());
  await Hive.openBox(BOX_SETTINGS);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameManager>(
          create: (ctx) => GameManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'smol chess',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.indieFlower().fontFamily,
          //fontFamily: GoogleFonts.balsamiqSans().fontFamily,
          //fontFamily: GoogleFonts.spartan().fontFamily,
        ),
        home: HomePage(),
      ),
    );
  }
}
