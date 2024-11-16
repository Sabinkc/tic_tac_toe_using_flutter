import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/screens/field_screen_for_friend.dart';
import 'package:tic_tac_toe/screens/five_five_game_screen_with_friend.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/screens/splash_icon.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.dynaPuffTextTheme(
        Theme.of(context).textTheme,
      )),
      home: const HomeScreen(),
    );
  }
}
