import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/colors.dart';
import 'package:tic_tac_toe/common/common_button.dart';
import 'package:tic_tac_toe/features/playing_with_friend/five_five_game_screen_with_friend.dart';
import 'package:tic_tac_toe/features/playing_with_friend/game_screen_with_friend.dart';

class FieldScreenForFriend extends StatelessWidget {
  const FieldScreenForFriend({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final AudioPlayer audioPlayer = AudioPlayer();
    Future playButtonTapSound() async {
      await audioPlayer.play(AssetSource("button_pressed.mp3"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.primaryColor.withOpacity(0.5),
        leading: IconButton(
          onPressed: () {
            playButtonTapSound();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Text(
              "Choose board size",
              style:
                  TextStyle(color: Colors.white, fontSize: screenWidth * 0.09),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CommonButton(
              title: "3x3 board",
              buttonColor: CommonColors.primaryColor,
              titleColor: Colors.white,
              borderColor: Colors.white,
              onTap: () {
                playButtonTapSound();
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return const GameScreenWithFriend();
                }));
              },
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            CommonButton(
              title: "5x5 board",
              buttonColor: Colors.white,
              titleColor: CommonColors.primaryColor,
              borderColor: Colors.white,
              onTap: () {
                playButtonTapSound();
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return const FiveFiveGameScreenWithFriend();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
