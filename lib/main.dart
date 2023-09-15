import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meals/screens/screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meals/screens/startScreen.dart';
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor:const  Color.fromARGB(255, 0, 0, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
 
  runApp(const ProviderScope(child:  App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: StartScreen()// Todo ...,
    );
  }
}
