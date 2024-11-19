import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/common/common_button.dart';
import 'package:tic_tac_toe/features/playing%20with%20ai/field_screen_for_ai.dart';
import 'package:tic_tac_toe/features/playing_with_friend/field_screen_for_friend.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Total height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final AudioPlayer audioPlayer = AudioPlayer();

    @override
    void dispose() {
      audioPlayer.dispose(); // Dispose of the audio player
      super.dispose();
    }

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.withOpacity(0.5), CommonColors.primaryColor],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animate the "o" and "x" texts sliding down from above
            TweenAnimationBuilder(
              tween: Tween<double>(begin: -screenHeight / 4, end: 0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "o",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "x",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: screenWidth * 0.1),

            // Animate the opacity of "Choose a play mode"
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Text(
                    "Choose a play mode",
                    style: TextStyle(
                        color: Colors.white, fontSize: screenHeight * 0.03),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.03),

            // Animate the "With AI" button sliding in from below
            TweenAnimationBuilder(
              tween: Tween<double>(begin: screenHeight, end: 0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: CommonButton(
                    title: "With AI",
                    buttonColor: Colors.white,
                    titleColor: CommonColors.primaryColor,
                    borderColor: Colors.white,
                    onTap: () async {
                      try {
                        await audioPlayer
                            .play(AssetSource("button_pressed.mp3"));
                      } catch (e) {
                        print("Error playing sound: $e");
                      }
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const FieldScreenForAi(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.015),

            // Animate the "With a friend" button sliding in from below
            TweenAnimationBuilder(
              tween: Tween<double>(begin: screenHeight, end: 0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: CommonButton(
                    title: "With a friend",
                    buttonColor: CommonColors.primaryColor,
                    titleColor: Colors.white,
                    borderColor: Colors.white,
                    onTap: () async {
                      await audioPlayer.play(AssetSource("button_pressed.mp3"));
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const FieldScreenForFriend(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
